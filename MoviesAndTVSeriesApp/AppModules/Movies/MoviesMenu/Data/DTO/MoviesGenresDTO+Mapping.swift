//
//  MoviesGenresDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 26/01/24.
//

import Foundation

extension MoviesGenresDTO {
    func toDomain() -> [MGenre]{
        
//        [18, 99, 10402, 10749].removeFirstOccurrence(of: Int)
        
//        genres.filter { $0.id != 18 && $0.id != 99 && $0.id != 10402 && $0.id != 10749 }
        genres
        
    }
}

