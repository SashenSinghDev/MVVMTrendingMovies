//
//  NetworkConfigMock.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 05.12.20.
//

import Foundation
@testable import MVVMTrendingMovies

class NetworkConfigMock: NetworkConfig {
    var baseURL: URL
    var headers: [String : String]
    var queryParameters: [String : String]

    init(baseURL: URL,
         headers: [String: String] = [:],
         queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
