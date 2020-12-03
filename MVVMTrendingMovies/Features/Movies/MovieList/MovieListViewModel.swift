//
//  MovieListViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation

enum MovieListViewState: Equatable {
    static func == (lhs: MovieListViewState, rhs: MovieListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.finishedLoading, .finishedLoading):
            return true
        case (.error(let errorLHS), .error(let errorRHS)):
            return errorLHS == errorRHS
        default:
            return false
        }
    }

    case loading
    case finishedLoading
    case error(error: String)
}

final class MovieListViewModel {
    var viewState: DynamicType<MovieListViewState> = DynamicType<MovieListViewState>()
    private let movieResponder: MovieResponder
    private let movieRepository: MoviesRepository
    private var movies: [Movie] = []

    init(movieResponder: MovieResponder,
         movieRepository: MoviesRepository) {
        self.movieResponder = movieResponder
        self.movieRepository = movieRepository
    }

    var numberOfMovies: Int {
        return movies.count
    }

    func loadMovies() {
        viewState.value = .loading
        movieRepository.fetchMovies { [weak self] movieResult in
            guard let self = self else { return }

            switch movieResult {
            case .success(let movies):
                self.movies = movies
                self.viewState.value = .finishedLoading
            case .failure(let error):
                self.viewState.value = .error(error: error.message)
            }
        }
    }

    func movie(for indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}

extension MovieListViewModel: MovieResponder {
    func showMovieDetail(movie: Movie) {
        movieResponder.showMovieDetail(movie: movie)
    }
}
