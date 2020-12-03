//
//  DefaultNetworkService.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation

protocol NetworkSession {
  func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

final class DefaultNetworkService: NetworkService {
    private let session: NetworkSession
    private let config: NetworkConfig
    
    init(session: NetworkSession = URLSession.shared,
         config: NetworkConfig) {
        self.session = session
        self.config = config
    }

    func requestData(with endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request = self.urlRequest(with: endpoint) else {
            return
        }

        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.nonFatal(error: error)))
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.noContentReturned))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }

    private func urlRequest(with endpoint: Endpoint) -> URLRequest? {
        var urlComponents = URLComponents(string: config.baseURL.absoluteString)
        urlComponents?.path = "/\(endpoint.version)/\(endpoint.path)"
        urlComponents?.setQueryItems(with: config.queryParameters)

        guard let url = urlComponents?.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
