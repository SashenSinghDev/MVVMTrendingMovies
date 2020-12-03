//
//  MovieListItemCell.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 01.12.20.
//

import Foundation
import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    private struct Constants {
        static let itemImageWidth: CGFloat = 64.0
        static let itemImageHeight: CGFloat = 64.0
    }

    // Properties
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 6
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setup() {
        backgroundColor = .white
        addSubview(contentStackView)
        contentStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        addImage()
        addLabels()
    }

    private func addImage() {
        contentStackView.addArrangedSubview(movieImage)
        movieImage.addSizeConstraints(width: Constants.itemImageWidth,
                                      height: Constants.itemImageHeight)
    }

    private func addLabels() {
        let labelStackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieReleaseDateLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 6
        contentStackView.addArrangedSubview(labelStackView)
    }

    // MARK: - Public

    func configure(with viewModel: MovieListCellViewModel) {
        movieTitleLabel.text = viewModel.movieTitle
        movieReleaseDateLabel.text = viewModel.releaseDate

        viewModel.getImage(with: Int(Constants.itemImageWidth)) { image in
            self.movieImage.image = image
        }
    }
}
