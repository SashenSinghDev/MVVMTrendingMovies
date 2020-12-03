//
//  MovieRepositoryMock.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 06.12.20.
//

import Foundation
@testable import MVVMTrendingMovies

class MoviesRespositoryMock: MoviesRepository {
    var movies: [Movie] = []
    var fetchError: FetchError? = nil
    var fetchMoviesCount = 0
    func fetchMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        fetchMoviesCount += 1
        if let error = fetchError {
            completion(.failure(error))
            return
        }

        completion(.success(movies))
    }
}
