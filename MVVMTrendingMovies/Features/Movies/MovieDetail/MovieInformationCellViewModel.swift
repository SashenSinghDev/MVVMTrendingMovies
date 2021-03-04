//
//  MovieDetailCellViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.03.21.
//

import Foundation

final class MovieInformationCellViewModel {
    private let movie: Movie

    var movieTitle: String {
        return movie.title
    }

    var releaseDate: String {
        return movie.releaseDate
    }

    var movieOverview: String {
        return movie.overview
    }

    init(movie: Movie) {
        self.movie = movie
    }
}
