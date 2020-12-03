//
//  LoadingView.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 02.12.20.
//

import Foundation
import UIKit

final class LoadingView: UIView {
    // MARK: - Properties
    private let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        return loadingIndicator
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
        addSubview(loadingIndicator)
        loadingIndicator.anchorCentrally(to: self)
        loadingIndicator.addSizeConstraints(width: 16, height: 16)

        backgroundColor = .white
    }

    // MARK: - Public

    func startAnimatingIndicator() {
        self.alpha = 1
        self.loadingIndicator.startAnimating()
    }

    func stopAnimatingIndicator() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }

            self.alpha = 0
            self.loadingIndicator.stopAnimating()
        }
    }
}
