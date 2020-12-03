//
//  MovieListViewModelTests.swift
//  MVVMTrendingMoviesTests
//
//  Created by Sashen Singh on 06.12.20.
//

import XCTest
@testable import MVVMTrendingMovies

class MovieListViewModelTests: XCTestCase {
    private var sut: MovieListViewModel!
    private var movieResponder: MovieResponderMock!
    private var movieRepository: MoviesRespositoryMock!

    override func setUp() {
        super.setUp()

        movieResponder = MovieResponderMock()
        movieRepository = MoviesRespositoryMock()
        sut = MovieListViewModel(movieResponder: movieResponder,
                                 movieRepository: movieRepository)
    }

    override func tearDown() {
        sut = nil
        movieResponder = nil
        movieRepository = nil

        super.tearDown()
    }

    func test_loadMovies_finishLoadsMovies_forSuccessfulMoviesFetch() {
        var observedStates: [MovieListViewState] = []

        let mockMovie = createMockMovie()
        movieRepository.movies = [mockMovie]

        let expectedStates: [MovieListViewState] = [
            .loading,
            .finishedLoading
        ]

        sut.viewState.bind { state in
            observedStates.append(state)
        }

        sut.loadMovies()

        compare(observed: observedStates, to: expectedStates)
        XCTAssert(movieRepository.fetchMoviesCount == 1, "Fetch movies count should be 1")
    }

    func test_loadMovies_returnsError_forFetchError() {
        var observedStates: [MovieListViewState] = []

        let mockError: FetchError = FetchError(message: "mockError")
        movieRepository.fetchError = mockError

        let expectedStates: [MovieListViewState] = [
            .loading,
            .error(error: mockError.message)
        ]

        sut.viewState.bind { state in
            observedStates.append(state)
        }

        sut.loadMovies()

        compare(observed: observedStates, to: expectedStates)
        XCTAssert(movieRepository.fetchMoviesCount == 1, "Fetch movies count should be 1")
    }

    func test_showMovieDetail_callsMovieResponder_withCorrectMovie() {
        let mockMovie = createMockMovie()

        sut.showMovieDetail(movie: mockMovie)

        XCTAssert(movieResponder.showMovieDetailsCount == 1, "Movie responder call count should be 1")
        XCTAssertEqual(mockMovie, movieResponder.movie)
    }

    func test_numberOfMovies_returnsCorrectNumberOfMovies() {
        let movies = [createMockMovie(), createMockMovie()]
        movieRepository.movies = movies

        sut.loadMovies()

        XCTAssertEqual(sut.numberOfMovies, movies.count)
    }

    func test_movieForIndexPath_returnsCorrectMovie() {
        let movieToCheck = createMockMovie(withTitle: "mockTitle 2")
        let movies = [createMockMovie(withTitle: "mockTitle 1"), movieToCheck]
        let indexPathToCheck = IndexPath(row: 1, section: 0)
        movieRepository.movies = movies

        sut.loadMovies()

        XCTAssertEqual(sut.movie(for: indexPathToCheck), movieToCheck)
    }

    private func createMockMovie(withTitle title: String? = nil) -> Movie {
        return Movie(id: 1,
                     title: title ?? "mockTitle",
                     releaseDate: "2001-08-09",
                     overview: "mockOverview",
                     posterImageURLPath: "mockPath",
                     voteAverage: 0.0)
    }

    private func compare(observed: [MovieListViewState],
                         to expectedStates: [MovieListViewState]) {

        guard observed.count == expectedStates.count else {
            XCTFail("Incorrect number of states observed")
            return
        }

        for (index, observedState) in observed.enumerated() {
            XCTAssertEqual(observedState, expectedStates[index])
        }
    }
}
