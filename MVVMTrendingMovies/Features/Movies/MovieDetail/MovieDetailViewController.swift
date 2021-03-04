//
//  MovieDetailViewController.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation
import UIKit

final class MovieDetailViewController: UIViewController {
    private let movieDetailViewModel: MovieDetailViewModel
    private let movieDetailImageCellViewModel: MovieDetailImageCellViewModel
    private let movieInformationCellViewModel: MovieInformationCellViewModel
    private let movieDetailCollectionView: UICollectionView = {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    init(movieDetailViewModel: MovieDetailViewModel,
         movieDetailImageCellViewModel: MovieDetailImageCellViewModel,
         movieInformationCellViewModel: MovieInformationCellViewModel) {
        self.movieDetailViewModel = movieDetailViewModel
        self.movieDetailImageCellViewModel = movieDetailImageCellViewModel
        self.movieInformationCellViewModel = movieInformationCellViewModel

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailCollectionView.backgroundColor = .white
    }

    private func setup() {
        view.addSubview(movieDetailCollectionView)
        movieDetailCollectionView.fillSuperview(padding: .zero)
        movieDetailCollectionView.delegate = self
        movieDetailCollectionView.dataSource = self

        movieDetailCollectionView.register(MovieDetailImageCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieDetailImageCollectionViewCell.self))
        movieDetailCollectionView.register(MovieInformationCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieInformationCollectionViewCell.self))
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieDetailViewModel.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch movieDetailViewModel.sections[indexPath.row] {
        case .image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MovieDetailImageCollectionViewCell.self), for: indexPath) as? MovieDetailImageCollectionViewCell else {
                fatalError("cannot deque cell")
            }

            cell.delegate = self
            cell.configure(with: movieDetailImageCellViewModel)
            return cell
        case .movieDetail:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MovieInformationCollectionViewCell.self), for: indexPath) as? MovieInformationCollectionViewCell else {
                fatalError("cannot deque cell")
            }

            cell.configure(with: movieInformationCellViewModel)
            return cell
        }
    }
}

extension MovieDetailViewController: MovieDetailImageDelegate {
    func didFinishLoadImage() {
        self.movieDetailCollectionView.collectionViewLayout.invalidateLayout()
    }
}
