//
//  DefaultImageRepository.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 03.12.20.
//

import UIKit

var movieImageCache = [String: MovieImage]()

final class DefaultImageRepository: ImageRepository {
    private let networkService: NetworkService
    private let validImageWidthSizes: [Int]

    init(networkService: NetworkService,
         validImageWidthSizes: [Int] = [92, 154, 185, 342, 500, 780]) {
        self.networkService = networkService
        self.validImageWidthSizes = validImageWidthSizes
    }

    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {

        if let cachedImage = movieImageCache[imagePath],
           cachedImage.size == width {
            completion(.success(cachedImage.image))
            return
        }

        let imageWidth = getClosestValidImageSizeWidth(from: width)
        let endpoint = APIEndpoints.getMovieImage(path: imagePath, width: imageWidth)

        networkService.requestData(with: endpoint) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                movieImageCache[imagePath] = MovieImage(image: image, size: imageWidth)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error.handleError()))
            }
        }
    }

    private func getClosestValidImageSizeWidth(from suggestedWidth: Int) -> Int {
        return validImageWidthSizes.enumerated().min { abs($0.1 - suggestedWidth) < abs($1.1 - suggestedWidth) }?.element ?? validImageWidthSizes.first!
    }
}
