//
//  SearchMediaDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

extension SearchMediaDTO {
    
    func toDomain() -> (pages: Int, results: [SearchResults]){
//        var moviesFiltered = results
//        
//        if idGenre != AppLocalized.allGenresId {
//            
//            moviesFiltered = results.filter {
//                $0.genreIDS?.contains(idGenre) as? Bool ?? false
//            }
//            
//        }
        let totalPages = totalPages
        return (totalPages, results)
        
    }
}
