//
//  MovieListCellViewModelTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 25.02.21.
//

import XCTest
@testable import MVVMTrendingMovies

class MovieListCellViewModelTests: XCTestCase {
    private var sut: MovieListCellViewModel!
    private var imageRepository: ImageRepositoryMock!
    private var movie: Movie!
    private let mockTitle = "mockTitle"
    private let mockReleaseDate = "2001-08-09"

    override func setUp() {
        super.setUp()

        imageRepository = ImageRepositoryMock()
        movie = Movie(id: 1,
                      title: mockTitle,
                      releaseDate: mockReleaseDate,
                      overview: "mockOverview",
                      posterImageURLPath: "mockPath",
                      voteAverage: 0.0)
        sut = MovieListCellViewModel(movie: movie,
                                     imageRepository: imageRepository)
    }

    override func tearDown() {
        sut = nil
        movie = nil
        imageRepository = nil

        super.tearDown()
    }

    func test_movieTitle_returnsCorrectTitle() {
        let movieTitle = sut.movieTitle

        XCTAssert(movieTitle == mockTitle, "Movie title is incorrect")
    }

    func test_releaseDate_returnsCorrectReleaseDate() {
        let movieTitle = sut.releaseDate

        XCTAssert(movieTitle == mockReleaseDate, "Release date is incorrect")
    }

    func test_getImage_returnsImage_forNoError() {
        let mockWidth = 100
        let mockImage = UIImage(named: "mockImage")
        imageRepository.image = mockImage

        sut.getImage(with: mockWidth) { image in
            XCTAssertEqual(mockImage, image)
        }
    }
}
