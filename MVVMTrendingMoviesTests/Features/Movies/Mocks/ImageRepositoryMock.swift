//
//  ImageRepositoryMock.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 25.02.21.
//

import Foundation
import UIKit
@testable import MVVMTrendingMovies

class ImageRepositoryMock: ImageRepository {
    var error: Error? = nil
    var image: UIImage? = nil

    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let image = image else {
            completion(.failure(NetworkError.noContentReturned))
            return
        }

        completion(.success(image))
    }
}
