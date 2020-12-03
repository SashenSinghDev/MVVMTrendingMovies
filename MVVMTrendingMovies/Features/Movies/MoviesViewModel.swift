//
//  MoviesViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 07.11.20.
//

import Foundation

enum MoviesViewState {
    case movieList
    case movieDetail(movie: Movie)
}

protocol MovieResponder {
    func showMovieDetail(movie: Movie)
}

final class MoviesViewModel: MovieResponder {
    var viewState: DynamicType<MoviesViewState> = DynamicType<MoviesViewState>()

    init() {
        viewState.value = .movieList
    }

    func showMovieDetail(movie: Movie) {
        viewState.value = .movieDetail(movie: movie)
    }
}
