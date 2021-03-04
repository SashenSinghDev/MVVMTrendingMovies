//
//  MovieDetailImageCellViewModelTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 14.03.21.
//

import Foundation
import XCTest
@testable import MVVMTrendingMovies

class MovieDetailImageCellViewModelTests: XCTestCase {
    private var sut: MovieDetailImageCellViewModel!
    private let posterImageURLPath = "mockPath"
    private var imageRepository: ImageRepositoryMock!

    override func setUp() {
        super.setUp()
        imageRepository = ImageRepositoryMock()
        sut = MovieDetailImageCellViewModel(posterURL: posterImageURLPath,
                                            imageRepository: imageRepository)
    }

    override func tearDown() {
        sut = nil
        imageRepository = nil

        super.tearDown()
    }

    func test_getImage_finishLoadsImage_forSuccessfulImageFetch() {
        var observedStates: [MovieDetailImageViewState] = []
        let expectation = self.expectation(description: "Should return image")
        let expectedStates: [MovieDetailImageViewState] = [
            .loading,
            .finishedLoading
        ]

        sut.viewState.bind { state in
            observedStates.append(state)
        }

        let mockWidth = 100
        let mockImage = UIImage()
        imageRepository.image = mockImage

        sut.getImage(with: mockWidth) { image in
            XCTAssertEqual(mockImage, image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        self.compare(observed: observedStates, to: expectedStates)
    }

    func test_getImage_returnsError_forUnsuccessfulImageFetch() {
        var observedStates: [MovieDetailImageViewState] = []
        let expectation = self.expectation(description: "Should not return image")
        let mockImageWidth = 100
        let expectedStates: [MovieDetailImageViewState] = [
            .loading,
            .error
        ]

        sut.viewState.bind { state in
            observedStates.append(state)
        }

        imageRepository.error = NetworkError.noContentReturned

        sut.getImage(with: mockImageWidth) { image in
            XCTAssertNil(image)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)

        self.compare(observed: observedStates, to: expectedStates)
    }

    private func compare(observed: [MovieDetailImageViewState],
                         to expectedStates: [MovieDetailImageViewState]) {

        guard observed.count == expectedStates.count else {
            XCTFail("Incorrect number of states observed")
            return
        }

        for (index, observedState) in observed.enumerated() {
            XCTAssertEqual(observedState, expectedStates[index])
        }
    }
}
