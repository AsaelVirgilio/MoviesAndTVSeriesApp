//
//  MoviesDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

extension MoviesDTO {
    
    func toDomain(idGenre: Int) -> [Movie]{
        var moviesFiltered = results
        
        if idGenre != AppLocalized.allGenresId {
            
            moviesFiltered = results.filter {
                $0.genreIDS.contains(idGenre)
            }
            
        }
        
        return moviesFiltered
        
    }
}
