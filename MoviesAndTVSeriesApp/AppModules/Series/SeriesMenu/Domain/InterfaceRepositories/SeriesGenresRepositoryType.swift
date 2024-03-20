//
//  SeriesGenresRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

protocol SeriesGenresRepositoryType {
    func fetchSeriesGenres() async throws -> [SeriesGenres]
}
