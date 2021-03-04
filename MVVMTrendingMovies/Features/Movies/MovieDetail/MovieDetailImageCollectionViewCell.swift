//
//  MovieDetailImageCollectionViewCell.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 04.03.21.
//

import Foundation
import UIKit

protocol MovieDetailImageDelegate: class {
    func didFinishLoadImage()
}

final class MovieDetailImageCollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let errorLabel = UILabel()
    private let screen: UIScreen = .main
    private let loadingIndicator = UIActivityIndicatorView()
    weak var delegate: MovieDetailImageDelegate?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        movieImage.layoutIfNeeded()
    }

    // MARK: - Private

    private func setup() {
        addSubview(movieImage)
        movieImage.fillSuperview(padding: .zero)

        addSubview(loadingIndicator)
        loadingIndicator.anchorCentrally(to: self)

        addSubview(errorLabel)
        errorLabel.anchorCentrally(to: self)
    }

    // MARK: - Public

    func configure(with viewModel: MovieDetailImageCellViewModel) {
        viewModel.getImage(with: Int(self.screen.bounds.width)) { image in
            self.movieImage.image = image
        }

        viewModel.viewState.bind {  [weak self] viewState in
            guard let self = self else { return }

            switch viewState {
            case .loading:
                self.loadingIndicator.startAnimating()
            case .finishedLoading:
                self.delegate?.didFinishLoadImage()
                self.loadingIndicator.stopAnimating()
            case .error:
                self.loadingIndicator.stopAnimating()
                self.errorLabel.text = viewModel.errorText
            }
        }
    }
}
