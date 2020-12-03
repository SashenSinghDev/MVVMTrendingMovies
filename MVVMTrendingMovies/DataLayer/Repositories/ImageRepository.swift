//
//  ImageRepository.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 03.12.20.
//

import UIKit

protocol ImageRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<UIImage, Error>) -> Void)
}
