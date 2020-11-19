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
    case nonFatal(error: NSError)
}
