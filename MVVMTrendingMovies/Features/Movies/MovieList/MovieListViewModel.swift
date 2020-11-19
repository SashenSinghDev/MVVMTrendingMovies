//
//  MovieListViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation

enum MovieListViewState {
    case loading
    case finishedLoading
    case error(error: String)
}

final class MovieListViewModel {
    var viewState: DynamicType<MovieListViewState> = DynamicType<MovieListViewState>()
    private let movieResponder: MovieResponder
    private let movieRepository: MoviesRepository

    init(movieResponder: MovieResponder,
         movieRepository: MoviesRepository) {
        self.movieResponder = movieResponder
        self.movieRepository = movieRepository
    }

    func loadMovies() {
        movieRepository.fetchMovies { movieResult in
        }
    }
}

extension MovieListViewModel: MovieResponder {
    func showMovieDetail() {
        movieResponder.showMovieDetail()
    }
}
