//
//  MovieListViewController.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModel

    init(movieListViewModel: MovieListViewModel) {
        self.viewModel = movieListViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        viewModel.loadMovies()
    }

    private func bindToViewModel() {
        viewModel.viewState.bind { movieListState in
            switch movieListState {
            case .loading:
                break
            case .finishedLoading:
                break
            case .error(error: let error):
                break
            }
        }
    }
}
