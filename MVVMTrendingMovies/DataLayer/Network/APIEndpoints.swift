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
        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!

        return Endpoint(path: "t/p/w\(closestWidth)\(path)", version: "")
    }
}
