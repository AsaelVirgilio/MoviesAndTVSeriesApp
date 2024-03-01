//
//  MoviesRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

protocol MoviesRepositoryType {
    mutating func fetchMovies(pageNum: Int) async throws -> [Movie]
}
