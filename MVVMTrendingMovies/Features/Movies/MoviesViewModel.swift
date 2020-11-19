//
//  MoviesViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 07.11.20.
//

import Foundation

enum MoviesViewState {
    case movieList
    case movieDetail
}

protocol MovieResponder {
    func showMovieDetail()
}

final class MoviesViewModel: MovieResponder {
    var viewState: DynamicType<MoviesViewState> = DynamicType<MoviesViewState>()

    init() {
        viewState.value = .movieList
    }

    func showMovieDetail() {
        viewState.value = .movieDetail
    }
}
