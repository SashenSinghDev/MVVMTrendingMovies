//
//  Endpoint.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 19.11.20.
//

import Foundation

final class Endpoint {
    let path: String
    let version: String

    init(path: String,
         version: String = "3") {
        self.path = path
        self.version = version
    }
}
