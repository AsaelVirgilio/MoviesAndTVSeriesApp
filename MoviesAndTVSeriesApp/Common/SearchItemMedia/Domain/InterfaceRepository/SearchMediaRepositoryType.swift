//
//  SearchMediaRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

protocol SearchMediaRepositoryType {
    func fetchSearchMediaResults(pageNum: Int) async throws -> [SearchResults]
}
