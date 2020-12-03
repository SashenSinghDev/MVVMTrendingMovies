//
//  DefaultNetworkServiceTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 05.12.20.
//

import XCTest
@testable import MVVMTrendingMovies

class DefaultNetworkServiceTests: XCTestCase {
    private var sut: DefaultNetworkService!
    private var networkSession: NetworkSessionMock!
    private var networkConfig: NetworkConfigMock!

    override func setUp() {
        super.setUp()

        networkSession = NetworkSessionMock()
        networkConfig = NetworkConfigMock(baseURL: URL(string: "www.mockurl.com")!)
        sut = DefaultNetworkService(session: networkSession,
                                    config: networkConfig)
    }

    override func tearDown() {
        networkSession = nil
        networkConfig = nil
        sut = nil

        super.tearDown()
    }

    func test_requestData_returnsSuccess_forValidData() {
        let expectation = self.expectation(description: "Should return correct data")
        let expectedData = Data([0, 1, 0, 1])
        networkSession.data = expectedData

        let mockEndpoint = Endpoint(path: "mockPath")
        sut.requestData(with: mockEndpoint) { result in
            switch result {
            case .success(let responseData):
                XCTAssertEqual(responseData, expectedData)
                expectation.fulfill()
            case .failure:
                XCTFail("Proper response not returned for valid data")
            }
        }

        wait(for: [expectation], timeout: 0.1)
    }

    func test_requestData_returnsCorrectError_forResponseWithErrorCode() {
        let expectation = self.expectation(description: "Should return an error")
        let mockResponseCode = 400
        let mockHttpResponse = HTTPURLResponse(url: networkConfig.baseURL,
                                               statusCode: mockResponseCode,
                                               httpVersion: nil, headerFields: nil)
        networkSession.urlResponse = mockHttpResponse

        let mockEndpoint = Endpoint(path: "mockPath")
        sut.requestData(with: mockEndpoint) { result in
            switch result {
            case .success:
                XCTFail("Expected to get an error for response")
            case .failure(let error):
                let networkError = error as NetworkError
                if networkError.message == "\(mockResponseCode) Error occured" {
                    expectation.fulfill()
                } else {
                    XCTFail("Incorrect network error given")
                }
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_requestData_returnsError_forNoValidData() {
        let expectation = self.expectation(description: "Should return an error")

        let mockEndpoint = Endpoint(path: "mockPath")
        sut.requestData(with: mockEndpoint) { result in
            switch result {
            case .success:
                XCTFail("Expected to get an error for response")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_requestData_returnsError_forError() {
        let expectation = self.expectation(description: "Should return an error")

        networkSession.error = NSError()

        let mockEndpoint = Endpoint(path: "mockPath")
        sut.requestData(with: mockEndpoint) { result in
            switch result {
            case .success:
                XCTFail("Expected to get an error for response")
            case .failure:
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
