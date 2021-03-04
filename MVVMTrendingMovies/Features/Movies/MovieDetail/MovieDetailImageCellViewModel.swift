//
//  MovieDetailImageCellViewModel.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.03.21.
//

import Foundation
import UIKit

enum MovieDetailImageViewState: Equatable {
    static func == (lhs: MovieDetailImageViewState, rhs: MovieDetailImageViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.finishedLoading, .finishedLoading):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

    case loading
    case finishedLoading
    case error
}

final class MovieDetailImageCellViewModel {
    private let posterURL: String
    private let imageRepository: ImageRepository
    let errorText = "Unable to load image"
    var viewState: DynamicType<MovieDetailImageViewState> = DynamicType<MovieDetailImageViewState>()

    init(posterURL: String, imageRepository: ImageRepository) {
        self.posterURL = posterURL
        self.imageRepository = imageRepository
    }

    func getImage(with width: Int, completion: @escaping (UIImage?) -> Void) {
        viewState.value = .loading
        imageRepository.fetchImage(with: posterURL,
                                   width: width) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let image):
                completion(image)
                self.viewState.value = .finishedLoading
            case .failure:
                self.viewState.value = .error
                completion(nil)
            }
        }
    }
}
