//
//  MoviesDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

extension MoviesDTO {
    func toDomain(idGenre: Int) -> [Movie]{
        //        let moviesFiltered = results.filter {
        //             $0.genreIDS.contains(idGenre)
        //        }
        
//        let moviesFiltered = results.filter {
//            ($0.genreIDS.firstIndex(of: idGenre) != nil) == true
//        }
        var moviesFiltered: [Movie] = []
        results.forEach {
            if $0.genreIDS.firstIndex(of: idGenre) != nil {
                print("-----> lo tiene la pelicula \($0.originalTitle), \($0.genreIDS)")
                moviesFiltered.append($0)
            }
        }
        
        return moviesFiltered
    }
}
