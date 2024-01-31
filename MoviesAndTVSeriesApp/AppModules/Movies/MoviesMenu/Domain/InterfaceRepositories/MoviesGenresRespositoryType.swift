//
//  MoviesRespositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

protocol MoviesGenresRespositoryType {
    func fetchMovies() async throws -> [MGenre]
}
