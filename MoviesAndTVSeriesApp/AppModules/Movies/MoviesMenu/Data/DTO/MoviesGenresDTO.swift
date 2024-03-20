//
//  MoviesGenresDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//


import Foundation

// MARK: - MovieGenres
struct MoviesGenresDTO: Codable {
    let genres: [MGenreDTO]
}

// MARK: - Genre
struct MGenreDTO: Codable {
    let id: Int
    let name: String
}

