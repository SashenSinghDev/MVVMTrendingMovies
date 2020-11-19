//
//  NetworkConfig.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 19.11.20.
//

import Foundation

public protocol NetworkConfig {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

public struct ApiDataNetworkConfig: NetworkConfig {
    public let baseURL: URL
    public let headers: [String: String]
    public let queryParameters: [String: String]

     public init(baseURL: URL,
                 headers: [String: String] = [:],
                 queryParameters: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
