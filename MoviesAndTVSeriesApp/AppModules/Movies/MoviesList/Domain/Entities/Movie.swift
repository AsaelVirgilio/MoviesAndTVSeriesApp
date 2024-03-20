//
//  Movie.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 11/03/24.
//

import Foundation

struct Movie {
    
    let backdropPath: String?
    let id: Int
    let title, originalTitle, overview: String
    let posterPath: String?
    let genreIDS: [Int]
    let releaseDate: String
    let voteAverage: Double
    
}
