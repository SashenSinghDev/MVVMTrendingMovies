//
//  Error+FetchError.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 05.12.20.
//

import Foundation

extension Error {
    func handleError() -> FetchError {
        guard let networkError = self as? NetworkError else {
            return FetchError(message: self.localizedDescription)
        }
        return FetchError(message: networkError.message)
    }
}
