//
//  MoviesDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

// MARK: - MoviesDTO
struct MoviesDTO: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieDTO: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title, originalTitle, overview: String
    let posterPath: String?
    let genreIDS: [Int]
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

