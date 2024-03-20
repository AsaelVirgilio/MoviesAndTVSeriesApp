//
//  SearchMediaDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

extension SearchMediaDTO {
    
    func toDomain() -> (pages: Int, results: [SearchResults]){
        var moviesFiltered = results.map {
            SearchResults(backdropPath: $0.backdropPath,
                          genreIDS: $0.genreIDS,
                          id: $0.id,
                          originalLanguage: $0.originalLanguage,
                          originalTitle: $0.originalTitle,
                          overview: $0.overview,
                          posterPath: $0.posterPath,
                          releaseDate: $0.releaseDate,
                          title: $0.title,
                          voteAverage: $0.voteAverage)
        }
        let totalPages = totalPages
        return (totalPages, moviesFiltered)
        
    }
}
