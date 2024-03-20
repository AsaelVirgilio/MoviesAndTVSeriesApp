//
//  SerieDetail.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 14/03/24.
//

struct SerieDetail {
    let id: Int
    let backdropPath: String?
    let originalName, overview: String
    
    func getImage() -> String {
        AppLocalized.imagesURLPath(path: backdropPath ?? "")
    }
}
