//
//  MovieListItemViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 01.12.20.
//

import Foundation
import UIKit

final class MovieListCellViewModel {
    private let movie: Movie
    private let imageRepository: ImageRepository

    var movieTitle: String {
        return movie.title
    }

    var releaseDate: String {
        return movie.releaseDate
    }

    init(movie: Movie, imageRepository: ImageRepository) {
        self.movie = movie
        self.imageRepository = imageRepository
    }

    func getImage(with width: Int, completion: @escaping (UIImage?) -> Void) {
        imageRepository.fetchImage(with: movie.posterImageURLPath,
                                   width: width) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
}
