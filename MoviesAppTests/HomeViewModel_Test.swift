//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Ahmed Ali on 18/08/2025.
//

import XCTest
@testable import MoviesApp

final class HomeViewModel_Test: XCTestCase {
    func testFetchTrendingMoviesSuccess() async {
        let mockService = MockNetworkService()
        
        let movie = Movie(
            adult: false,
            backdropPath: "/8I37NtDffNV7AZlDa7uDvvqhovU.jpg",
            genreIDS: [28, 35],
            id: 19995,
            originalLanguage: "hi",
            originalTitle: "Bade Miyan Chote Miyan",
            overview: "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
            popularity: 1145.042,
            posterPath: "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
            releaseDate: "2009-12-15",
            title: "Avatar",
            video: false,
            voteAverage: 7.6,
            voteCount: 28031
        )
        
        let expectedResponse = MovieApiResponse(
            page: 1,
            results: [movie],
            totalPages: 500,
            totalResults: 10000
        )
        
        mockService.data = try! JSONEncoder().encode(expectedResponse)
        
        let viewModel = HomeViewModel()
        viewModel.movieService = mockService
        
        await viewModel.fetchTrending()
        
        XCTAssertEqual(viewModel.trendingMovies.count, 1)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchTrendingMoviesError() async {
        let mockService = MockNetworkService()
        mockService.error = URLError(.badServerResponse)
        
        let viewModel = HomeViewModel()
        viewModel.movieService = mockService
        
        await viewModel.fetchTrending()
        
        XCTAssertEqual(viewModel.trendingMovies.count, 0)
        XCTAssertNotNil(viewModel.error)
    }
}
