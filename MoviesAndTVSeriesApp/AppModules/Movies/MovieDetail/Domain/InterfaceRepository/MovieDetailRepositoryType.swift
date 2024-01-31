//
//  MovieDetailRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import Foundation

protocol MovieDetailRepositoryType {
    func fetchMovieDetail(movie: Movie) async -> MovieDetail
}

