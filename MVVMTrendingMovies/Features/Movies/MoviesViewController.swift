//
//  MovieViewController.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 07.11.20.
//

import Foundation
import UIKit

final class MoviesViewController: UINavigationController {
    private let moviesViewModel: MoviesViewModel
    private let movieListViewController: MovieListViewController
    private let makeMovieDetailViewController: (_ movie: Movie) -> MovieDetailViewController

    init(moviesViewModel: MoviesViewModel,
         movieListViewController: MovieListViewController,
         movieDetailViewControllerFactory: @escaping (_ movie: Movie) -> MovieDetailViewController) {
        self.moviesViewModel = moviesViewModel
        self.movieListViewController = movieListViewController
        self.makeMovieDetailViewController = movieDetailViewControllerFactory

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
    }

    private func bindToViewModel() {
        moviesViewModel.viewState.bind { [weak self] moviesViewState in
            guard let self = self else { return }

            switch moviesViewState {
            case .movieList:
                self.presentMovieList()
            case .movieDetail(let movie):
                self.presentMovieDetails(with: movie)
            }
        }
    }

    private func presentMovieList() {
        pushViewController(movieListViewController, animated: false)
    }

    private func presentMovieDetails(with movie: Movie) {
        let movieDetailViewController = makeMovieDetailViewController(movie)
        pushViewController(movieDetailViewController, animated: true)
    }
}
