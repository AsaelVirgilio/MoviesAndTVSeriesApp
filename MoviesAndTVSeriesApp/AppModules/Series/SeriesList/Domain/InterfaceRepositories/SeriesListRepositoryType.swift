//
//  SeriesListRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

protocol SeriesListRepositoryType {
    mutating func fetchFilteredSeries(pageNum: Int) async throws -> [Serie]
}
