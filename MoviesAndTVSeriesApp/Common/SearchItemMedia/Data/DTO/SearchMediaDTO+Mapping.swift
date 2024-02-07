//
//  SearchMediaDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

extension SearchMediaDTO {
    
    func toDomain(idGenre: Int) -> [SearchResults]{
        var moviesFiltered = results
        
        if idGenre != AppLocalized.allMoviesGenresId {
            
            moviesFiltered = results.filter {
                $0.genreIDS.contains(idGenre)
            }
            
        }
        
        return moviesFiltered
        
    }
}
