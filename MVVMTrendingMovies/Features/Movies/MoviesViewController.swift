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
    private let makeMovieDetailViewController: (_ viewModel: MovieDetailViewModel) -> MovieDetailViewController

    init(moviesViewModel: MoviesViewModel,
         movieListViewController: MovieListViewController,
         movieDetailViewControllerFactory: @escaping (_ viewModel: MovieDetailViewModel) -> MovieDetailViewController) {
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
            case .movieDetail:
                self.presentMovieDetails()
            }
        }
    }

    private func presentMovieList() {
        pushViewController(movieListViewController, animated: false)
    }

    private func presentMovieDetails() {
        let movieDetailViewModel = MovieDetailViewModel()
        let movieDetailViewController = makeMovieDetailViewController(movieDetailViewModel)
        pushViewController(movieDetailViewController, animated: true)
    }
}
