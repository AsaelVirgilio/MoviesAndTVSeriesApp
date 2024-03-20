//
//  MovieDetail+Extension.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 11/03/24.
//

import Foundation

extension MovieDetailDTO{
    func toDomain() -> MovieDetail {
        MovieDetail(id: self.id,
                    backdropPath: self.backdropPath,
                    originalTitle: self.originalTitle,
                    overview: self.overview)
    }
}
