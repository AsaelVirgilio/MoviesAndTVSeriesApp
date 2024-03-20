//
//  MoviesDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

extension MoviesDTO {
    
    func toDomain() -> [Movie]{
        
        return results.map { Movie(backdropPath: $0.backdropPath,
                                   id: $0.id,
                                   title: $0.title,
                                   originalTitle: $0.originalTitle,
                                   overview: $0.overview,
                                   posterPath: $0.posterPath,
                                   genreIDS: $0.genreIDS,
                                   releaseDate: $0.releaseDate,
                                   voteAverage: $0.voteAverage)}
        
    }
}
