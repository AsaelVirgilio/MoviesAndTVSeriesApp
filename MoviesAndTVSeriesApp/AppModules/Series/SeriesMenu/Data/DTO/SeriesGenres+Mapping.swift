//
//  SeriesGenres.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 11/03/24.
//

extension SeriesGenresDTO {
    func toDomain() -> [SeriesGenres] {
        genres.map { SeriesGenres(id: $0.id,
                                  name: $0.name)
        }
    }
}
