//
//  MovieInformationCellViewModelTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 14.03.21.
//

import Foundation
import XCTest
@testable import MVVMTrendingMovies

class MovieInformationCellViewModelTests: XCTestCase {
    private var sut: MovieInformationCellViewModel!
    private let movieTitle = "mockTitle"
    private let releaseDate = "2001-08-09"
    private let movieOverview = "mockOverview"

    override func setUp() {
        super.setUp()

        let mockMovie = createMockMovie()
        sut = MovieInformationCellViewModel(movie: mockMovie)
    }

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    func test_movieTitle_returnCorrectMovieTitle() {
        XCTAssertEqual(sut.movieTitle, movieTitle)
    }

    func test_releaseDate_returnsCorrectReleaseDate() {
        XCTAssertEqual(sut.releaseDate, releaseDate)
    }

    func test_movieOverview_returnsCorrectMovieOverview() {
        XCTAssertEqual(sut.movieOverview, movieOverview)
    }

    private func createMockMovie(withTitle title: String? = nil) -> Movie {
        return Movie(id: 1,
                     title: title ?? movieTitle,
                     releaseDate: releaseDate,
                     overview: movieOverview,
                     posterImageURLPath: "mockPath",
                     voteAverage: 0.0)
    }
}
