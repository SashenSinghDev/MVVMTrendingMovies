//
//  DefaultImageRepository.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 03.12.20.
//

import UIKit

var imageCache = [String: UIImage]()

final class DefaultImageRepository: ImageRepository {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<UIImage, Error>) -> Void) {

        if let cachedImage = imageCache[imagePath] {
            completion(.success(cachedImage))
            return
        }

        let endpoint = APIEndpoints.getMovieImage(path: imagePath, width: width)

        networkService.requestData(with: endpoint) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                imageCache[imagePath] = image
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error.handleError()))
            }
        }
    }
}
