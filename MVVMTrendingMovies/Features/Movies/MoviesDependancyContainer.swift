//
//  MoviesDependancyCoordinator.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 07.11.20.
//

import Foundation

final class MoviesDependancyContainer {
    let moviesViewModel: MoviesViewModel
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        func makeMoviesViewModel() -> MoviesViewModel {
            return MoviesViewModel()
        }

        moviesViewModel = makeMoviesViewModel()
        self.dependencies = dependencies
    }

    func makeMoviesViewController() -> MoviesViewController {
        let movieDetailViewControllerFactory = { (movieDetailViewModel: MovieDetailViewModel) in
            return self.makeMovieDetailViewController(movieDetailViewModel: movieDetailViewModel)
        }
        let movieListViewController = makeMovieListViewController()
        return MoviesViewController(moviesViewModel: moviesViewModel,
                                    movieListViewController: movieListViewController,
                                    movieDetailViewControllerFactory: movieDetailViewControllerFactory)
    }

    private func makeMovieListViewController() -> MovieListViewController {
        let movieListViewModel = makeMovieListViewModel()
        return MovieListViewController(movieListViewModel: movieListViewModel)
    }

    private func makeMovieListViewModel() -> MovieListViewModel {
        let movieRepository = DefaultMoviesRepository(networkService: dependencies.networkService)
        return MovieListViewModel(movieResponder: moviesViewModel,
                                  movieRepository: movieRepository)
    }


    private func makeMovieDetailViewController(movieDetailViewModel: MovieDetailViewModel) -> MovieDetailViewController {
        return MovieDetailViewController(movieDetailViewModel: movieDetailViewModel)
    }
}
