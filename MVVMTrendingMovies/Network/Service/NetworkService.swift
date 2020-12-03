//
//  NetworkSession.swift
//  MVVMTrendingMovies
//
//  Created by Sashen Singh on 08.11.20.
//

import Foundation

protocol NetworkService {
    func requestData(with endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
