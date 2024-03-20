//
//  ItemSeriesGenresViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

struct ItemSeriesGenresViewModel {
    
    private(set) var genre: SeriesGenres
    
    var idGenre: Int {
        genre.id
    }
    var name: String {
        genre.name
    }
    var imageName: String {
        genre.name
    }
    
}
