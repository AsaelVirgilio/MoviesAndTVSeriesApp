//
//  SeriesListDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

extension SeriesListDTO {
    func toDomain(idGenre: Int) -> [Serie] {
        var seriesFiltered = results
        
        if idGenre != AppLocalized.allGenresId {
            seriesFiltered = results.filter {
                $0.genreIDS.contains(idGenre)
            }
        }
        
        return seriesFiltered
    }
}
