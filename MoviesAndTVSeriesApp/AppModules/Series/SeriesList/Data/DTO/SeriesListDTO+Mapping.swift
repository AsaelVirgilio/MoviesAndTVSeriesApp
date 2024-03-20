//
//  SeriesListDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

extension SeriesListDTO {
    func toDomain(idGenre: Int) -> [Serie] {
        
         return results.map {
            
            let serieDetail = SerieDetail(id: $0.id,
                                          backdropPath: $0.backdropPath,
                                          originalName: $0.originalName,
                                          overview: $0.overview)
            return Serie(
                id: $0.id,
                name: $0.name,
                posterPath: $0.posterPath,
                genreIDS: $0.genreIDS,
                firstAirDate: $0.firstAirDate,
                voteAverage: $0.voteAverage,
                serieDetail: serieDetail
            )
             
        }
    }
}
