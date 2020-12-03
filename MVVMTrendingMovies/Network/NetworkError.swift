//
//  NetworkError.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation

enum NetworkError: Error {
    case noContentReturned
    case httpError(statusCode: Int)
    case nonFatal(error: Error)

    var message: String {
        switch self {
        case .noContentReturned, .nonFatal:
            return "An unknown error occured"
        case .httpError(let statusCode):
            return "\(statusCode) Error occured"
        }
    }
}
