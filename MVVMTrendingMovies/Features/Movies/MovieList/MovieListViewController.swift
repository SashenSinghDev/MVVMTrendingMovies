//
//  MovieListViewController.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 06.11.20.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
    private struct Constants {
        static let movieListCellHeight: CGFloat = 100
    }

    private let viewModel: MovieListViewModel
    private let makeMovieListCellViewModel: (_ movie: Movie) -> MovieListCellViewModel
    private let imageRepository: ImageRepository
    private let movieListCollectionView: UICollectionView
    private let loadingView: LoadingView = {
        let loadingView = LoadingView()
        return loadingView
    }()
    private let emptyStateView: EmptyStateView = {
        let emptyStateView = EmptyStateView()
        return emptyStateView
    }()

    init(movieListViewModel: MovieListViewModel,
         imageRepository: ImageRepository,
         movieListLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(),
         movieListCellViewModelFactory: @escaping (_ movie: Movie) -> MovieListCellViewModel) {
        self.viewModel = movieListViewModel
        self.imageRepository = imageRepository
        self.movieListCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: movieListLayout)
        self.makeMovieListCellViewModel = movieListCellViewModelFactory

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindToViewModel()
        viewModel.loadMovies()
    }

    private func setup() {
        setupCollectionView()

        view.addSubview(loadingView)
        loadingView.fillSuperview(padding: .zero)

        view.addSubview(emptyStateView)
        emptyStateView.fillSuperview(padding: .zero)
    }

    private func setupCollectionView() {
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self

        movieListCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieListCollectionViewCell.self))

        view.addSubview(movieListCollectionView)
        movieListCollectionView.fillSuperview(padding: .zero)
        movieListCollectionView.backgroundColor = .white
    }

    private func bindToViewModel() {
        viewModel.viewState.bind { [weak self] movieListState in
            guard let self = self else { return }

            switch movieListState {
            case .loading:
                self.loadingView.startAnimatingIndicator()
                self.emptyStateView.removeView()
            case .finishedLoading:
                self.loadingView.stopAnimatingIndicator()
                self.emptyStateView.removeView()
                self.reloadCollectionView()
            case .error(error: let errorString):
                self.loadingView.stopAnimatingIndicator()
                self.emptyStateView.showView(with: errorString)
            }
        }
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.movieListCollectionView.reloadData()
        }
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfMovies
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MovieListCollectionViewCell.self), for: indexPath) as? MovieListCollectionViewCell else {
            fatalError("cannot deque cell")
        }

        let cellViewModel = makeMovieListCellViewModel(viewModel.movie(for: indexPath))
        cell.configure(with: cellViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showMovieDetail(movie: viewModel.movie(for: indexPath))
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width,
                      height: Constants.movieListCellHeight)
    }
}

