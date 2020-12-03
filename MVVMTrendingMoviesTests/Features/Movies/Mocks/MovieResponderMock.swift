//
//  MovieResponderMock.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 06.12.20.
//

import Foundation
@testable import MVVMTrendingMovies

class MovieResponderMock: MovieResponder {
    var showMovieDetailsCount = 0
    var movie: Movie?
    func showMovieDetail(movie: Movie) {
        showMovieDetailsCount += 1
        self.movie = movie
    }
}
