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

    init(movieDetailViewModel: MovieDetailViewModel) {
        self.movieDetailViewModel = movieDetailViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}
