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

enum QueryParameters {
    case apiKey

    public func value() -> String {
        switch self {
        case .apiKey:
            return "65df045510b9e20f5347a021ba912cad"
        }
    }

    public var key: String {
        switch self {
        case .apiKey:
            return "api_key"
        }
    }
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

    func requestData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let request = self.urlRequest(with: url) else {
            return
        }

        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
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

    private func urlRequest(with url: URL) -> URLRequest? {
        var urlComponents = URLComponents(string: url.absoluteString)
        var queryItems = urlComponents?.queryItems

        queryItems?.append(URLQueryItem(name: QueryParameters.apiKey.key,
                                       value: QueryParameters.apiKey.value()))
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            return nil
        }

        return URLRequest(url: url)
    }
}
