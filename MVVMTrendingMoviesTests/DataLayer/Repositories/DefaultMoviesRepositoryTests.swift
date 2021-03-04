//
//  DefaultMoviesRepositoryTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 15.03.21.
//

import Foundation
import XCTest
@testable import MVVMTrendingMovies

class DefaultMoviesRepositoryTests: XCTestCase {
    private var sut: DefaultMoviesRepository!
    private var networkService: NetworkServiceMock!

    override func setUp() {
        super.setUp()

        networkService = NetworkServiceMock()
        sut = DefaultMoviesRepository(networkService: networkService)
    }

    override func tearDown() {
        networkService = nil
        sut = nil

        super.tearDown()
    }

    func test_fetchMovies_returnsMovies_forSuccessfulResponse() {
        let expectation = self.expectation(description: "Should return correct data")
        let mockMovie = Movie(id: 1,
                              title: "mockTitle",
                              releaseDate: "mockReleaseDate",
                              overview: "mockOverview",
                              posterImageURLPath: "mockPath",
                              voteAverage: 1.0)
        let movieResults = ["results": [mockMovie.dictionary]]
        networkService.dataDictionary = movieResults

        sut.fetchMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(mockMovie, movies.first)
                expectation.fulfill()
            case .failure:
                XCTFail("Proper response not returned for valid data")
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchMovies_returnsError_forUnSuccessfulResponse() {
        let expectation = self.expectation(description: "Should fail for no data")
        networkService.error = .noContentReturned

        sut.fetchMovies { result in
            switch result {
            case .success:
                XCTFail("Failure is expected")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }
}
