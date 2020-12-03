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
        let imageRepository = DefaultImageRepository(networkService: dependencies.imageService)

        let movieListCellViewModelFactory = { (movie: Movie) in
            return self.makeMovieListCellViewModel(movie: movie, imageRepository: imageRepository)
        }

        return MovieListViewController(movieListViewModel: movieListViewModel,
                                       imageRepository: imageRepository,
                                       movieListCellViewModelFactory: movieListCellViewModelFactory)
    }

    private func makeMovieListViewModel() -> MovieListViewModel {
        let movieRepository = DefaultMoviesRepository(networkService: dependencies.networkService)
        return MovieListViewModel(movieResponder: moviesViewModel,
                                  movieRepository: movieRepository)
    }


    private func makeMovieDetailViewController(movieDetailViewModel: MovieDetailViewModel) -> MovieDetailViewController {
        return MovieDetailViewController(movieDetailViewModel: movieDetailViewModel)
    }

    private func makeMovieListCellViewModel(movie: Movie, imageRepository: ImageRepository) -> MovieListCellViewModel {
        return MovieListCellViewModel(movie: movie, imageRepository: imageRepository)
    }
}
