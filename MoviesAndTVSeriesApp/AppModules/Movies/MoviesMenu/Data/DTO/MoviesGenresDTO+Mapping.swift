//
//  MoviesGenresDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 26/01/24.
//

import Foundation

extension MoviesGenresDTO {
    func toDomain() -> [MGenre]{
        
        genres.map { MGenre(id: $0.id, name: $0.name)}
        
    }
}

