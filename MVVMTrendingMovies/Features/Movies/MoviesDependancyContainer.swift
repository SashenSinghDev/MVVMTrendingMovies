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
        let movieDetailViewControllerFactory = { (movie: Movie) in
            return self.makeMovieDetailViewController(with: movie)
        }
        let movieListViewController = makeMovieListViewController()
        return MoviesViewController(moviesViewModel: moviesViewModel,
                                    movieListViewController: movieListViewController,
                                    movieDetailViewControllerFactory: movieDetailViewControllerFactory)
    }

    // MARK: - Movie List

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

    private func makeMovieListCellViewModel(movie: Movie, imageRepository: ImageRepository) -> MovieListCellViewModel {
        return MovieListCellViewModel(movie: movie, imageRepository: imageRepository)
    }

    // MARK: - Movie Detail

    private func makeMovieDetailViewController(with movie: Movie) -> MovieDetailViewController {
        let viewModel = makeMovieDetailViewModel(with: movie)
        let movieDetailImageCellViewModel = makeMovieDetailImageCellViewModel(with: viewModel.moviePosterURL)
        let movieInformationCellViewModel = makeMovieInformationCellViewModel(with: movie)
        return MovieDetailViewController(movieDetailViewModel: viewModel,
                                         movieDetailImageCellViewModel: movieDetailImageCellViewModel,
                                         movieInformationCellViewModel: movieInformationCellViewModel)
    }

    private func makeMovieDetailViewModel(with movie: Movie) -> MovieDetailViewModel {
        return MovieDetailViewModel(movie: movie)
    }

    private func makeMovieDetailImageCellViewModel(with posterURL: String) -> MovieDetailImageCellViewModel {
        let imageRepository = DefaultImageRepository(networkService: dependencies.imageService)
        return MovieDetailImageCellViewModel(posterURL: posterURL,
                                             imageRepository: imageRepository)
    }

    private func makeMovieInformationCellViewModel(with movie: Movie) -> MovieInformationCellViewModel {
        return MovieInformationCellViewModel(movie: movie)
    }
}
