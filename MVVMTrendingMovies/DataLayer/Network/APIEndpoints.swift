//
//  APIEndpoints.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 19.11.20.
//

import Foundation

struct APIEndpoints {

    static func getWeeklyTrendingMovies() -> Endpoint {
        return Endpoint(path: "trending/movie/week")
    }

    static func getMovieImage(path: String, width: Int) -> Endpoint {
        return Endpoint(path: "t/p/w\(width)\(path)", version: "")
    }
}
