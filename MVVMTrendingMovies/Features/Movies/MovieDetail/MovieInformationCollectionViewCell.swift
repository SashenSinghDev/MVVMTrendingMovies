//
//  MovieDetailCollectionViewCell.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.03.21.
//

import Foundation
import UIKit

final class MovieInformationCollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 16
        return stackView
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
         let label = UILabel()
         label.numberOfLines = 0
         return label
     }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setup() {
        addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true

        let bottomConstraint = contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomConstraint.isActive = true


        contentStackView.addArrangedSubview(movieTitleLabel)
        contentStackView.addArrangedSubview(releaseDateLabel)
        contentStackView.addArrangedSubview(overviewLabel)
    }

    // MARK: - Public

    func configure(with viewModel: MovieInformationCellViewModel) {
        movieTitleLabel.text = viewModel.movieTitle
        releaseDateLabel.text = viewModel.releaseDate
        overviewLabel.text = viewModel.movieOverview
    }
}

