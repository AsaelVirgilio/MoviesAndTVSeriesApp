//
//  SearchResults.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 11/03/24.
//

import Foundation
struct SearchResults {
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let voteAverage: Double?
}
