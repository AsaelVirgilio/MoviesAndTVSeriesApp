//
//  SeriesGenresDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Foundation

// MARK: - MovieGenres
struct SeriesGenresDTO: Codable {
    let genres: [SGenreDTO]
}

// MARK: - Genre
struct SGenreDTO: Codable {
    let id: Int
    let name: String
}
