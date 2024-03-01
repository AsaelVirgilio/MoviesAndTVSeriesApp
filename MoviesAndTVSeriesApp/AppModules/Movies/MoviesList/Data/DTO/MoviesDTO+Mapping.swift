//
//  MoviesDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

extension MoviesDTO {
    
    func toDomain() -> [Movie]{
        let moviesFiltered = results
        
        return moviesFiltered
        
    }
}
