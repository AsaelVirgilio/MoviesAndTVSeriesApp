//
//  ItemMoviesGenresViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import Foundation

struct ItemMoviesGenresViewModel {
    private(set) var genre: MGenre
    
    var idGenre: Int {
        genre.id
    }
    
    var name: String {
        genre.name
    }
    
    var image: String {
        genre.name
    }
}
