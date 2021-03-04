//
//  MovieDetailViewModelTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 14.03.21.
//

import Foundation

import XCTest
@testable import MVVMTrendingMovies

class MovieDetailViewModelTests: XCTestCase {
    private var sut: MovieDetailViewModel!
    private let posterImageURLPath = "mockPath"

    override func setUp() {
        super.setUp()

        let mockMovie = createMockMovie()
        sut = MovieDetailViewModel(movie: mockMovie)
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_sectionCount_returnCorrectCount() {
        let sectionCount = sut.sections.count

        XCTAssertEqual(sectionCount, sut.sectionCount)
    }

    func test_moviePosterURL_returnsCorrectURL() {
        XCTAssertEqual(sut.moviePosterURL, posterImageURLPath)
    }

    private func createMockMovie(withTitle title: String? = nil) -> Movie {
        return Movie(id: 1,
                     title: title ?? "mockTitle",
                     releaseDate: "2001-08-09",
                     overview: "mockOverview",
                     posterImageURLPath: posterImageURLPath,
                     voteAverage: 0.0)
    }
}
