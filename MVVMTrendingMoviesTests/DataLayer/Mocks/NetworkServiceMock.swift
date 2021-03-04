//
//  NetworkService.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 15.03.21.
//

import Foundation
@testable import MVVMTrendingMovies

final class NetworkServiceMock: NetworkService {
    var dataDictionary: [String: Any]?
    var error: NetworkError?
    var sampleData: Data?

    func requestData(with endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let data = dataDictionary {
            let jsonData = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)

            completion(.success(jsonData))
        } else if let sampleData = sampleData {
            completion(.success(sampleData))
        }
    }
}
