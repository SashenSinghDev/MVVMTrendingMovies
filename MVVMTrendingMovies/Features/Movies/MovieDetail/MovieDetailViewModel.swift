//
//  MovieDetailViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation
import UIKit

final class MovieDetailViewModel {
    enum Section: CaseIterable {
        case image
        case movieDetail
    }

    private let movie: Movie

    var sectionCount: Int {
        return  Section.allCases.count
    }

    var moviePosterURL: String {
        return movie.posterImageURLPath
    }

    let sections = Section.allCases

    init(movie: Movie) {
        self.movie = movie
    }
}
