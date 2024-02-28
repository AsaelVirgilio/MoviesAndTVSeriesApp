//
//  CreateSeriesListView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import Foundation

protocol CreateSeriesListView{
    func create(idGenre: Int) -> SeriesListView
}
