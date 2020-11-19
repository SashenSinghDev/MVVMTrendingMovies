//
//  MainViewController.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    private let moviesViewController: MoviesViewController
    private let mainViewModel: MainViewModel

    // MARK: - Init

    init(viewModel: MainViewModel,
         moviesViewController: MoviesViewController) {
        self.mainViewModel = viewModel
        self.moviesViewController = moviesViewController

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
    }

    private func bindToViewModel() {
        mainViewModel.mainViewState.bind { [weak self] mainViewState in
            guard let self = self else { return }

            switch mainViewState {
            case .movies:
                self.presentMovies()
            }
        }
    }

    private func presentMovies() {
        addFullScreen(childViewController: moviesViewController)
    }
}
