//
//  SearchMediaDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

import Foundation

// MARK: - SearchMediaDTO
struct SearchMediaDTO: Codable {
    let page: Int
    let results: [SearchResults]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResults: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
