//
//  DefaultImageRepositoryTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 15.03.21.
//

import Foundation
import XCTest
@testable import MVVMTrendingMovies

class DefaultImageRepositoryTests: XCTestCase {
    private var sut: DefaultImageRepository!
    private var networkService: NetworkServiceMock!
    private let validImageSizes = [100, 200, 300]

    override func setUp() {
        super.setUp()

        networkService = NetworkServiceMock()
        sut = DefaultImageRepository(networkService: networkService,
                                     validImageWidthSizes: validImageSizes)
    }

    override func tearDown() {
        networkService = nil
        sut = nil
        movieImageCache.removeAll()

        super.tearDown()
    }

    func test_fetchImage_returnsImage_forSuccessfulResponse() {
        let expectation = self.expectation(description: "Should return correct data")
        let mockImagePath = "mockImagePath"
        let mockImage = createImage(withColor: .red)
        let imageData = mockImage.pngData()
        networkService.sampleData = imageData

        sut.fetchImage(with: mockImagePath, width: 375) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                expectation.fulfill()
            case .failure:
                XCTFail("An image was expected to be returned")
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchImage_returnsError_forUnsuccessfulResponse() {
        let expectation = self.expectation(description: "Should return error")
        networkService.error = .noContentReturned
        let mockImagePath = "mockImagePath"

        sut.fetchImage(with: mockImagePath, width: 375) { result in
            switch result {
            case .success:
                XCTFail("Failure is expected")
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchImageForWidth_cachesCorrectImageWidth_basedOnValidImageSizes() {
        let expectation = self.expectation(description: "Should return correct data")
        let mockImagePath = "mockImagePath"
        let mockImage = createImage(withColor: .red)
        let imageData = mockImage.pngData()
        networkService.sampleData = imageData

        sut.fetchImage(with: mockImagePath, width: 375) { result in
            switch result {
            case .success:
                XCTAssertEqual(movieImageCache["mockImagePath"]?.size, 300)
                expectation.fulfill()
            case .failure:
                XCTFail("An image was expected to be returned")
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    private func createImage(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let image =  UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
        return image
    }
}
