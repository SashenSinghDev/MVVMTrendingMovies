//
//  NetworkSessionMock.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 05.12.20.
//

import Foundation
@testable import MVVMTrendingMovies

class MockDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

class NetworkSessionMock: NetworkSession {
    var urlRequest: URLRequest?
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    func dataTask(with url: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        urlRequest = url
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse

        return MockDataTask {
            completionHandler(data, urlResponse, error)
        }
    }
}
