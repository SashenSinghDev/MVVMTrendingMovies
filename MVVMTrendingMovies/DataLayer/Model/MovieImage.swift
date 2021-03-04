//
//  MovieImage.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 04.03.21.
//

import Foundation
import UIKit

struct MovieImage: Equatable {
    static func == (lhs: MovieImage, rhs: MovieImage) -> Bool {
        return lhs.image == rhs.image && lhs.size == rhs.size
    }

    let image: UIImage
    let size: Int
}
