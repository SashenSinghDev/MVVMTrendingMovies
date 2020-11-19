//
//  MovieRepository.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation

protocol MoviesRepository {
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}
