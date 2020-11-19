//
//  DefaultMoviesRepository.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation

final class DefaultMoviesRepository: MoviesRepository {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
    }
}
