//
//  VideoTrailerDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

// MARK: - MovieGenres
struct VideoTrailerDTO: Codable {
    let id: Int
    let results: [VideoDTO]
}

// MARK: - Result
struct VideoDTO: Codable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
