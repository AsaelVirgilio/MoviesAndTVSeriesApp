//
//  SerieDetailFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 15/03/24.
//

import Foundation

class SerieDetailFactory: CreateSerieDetailView {
    
    func create(serieDetail: SerieDetail) -> SerieDetailView {
        let loadSerieDetailUseCase = LoadSerieDetailUseCase(serieDetail: serieDetail)
        let serieDetailViewModel = SerieDetailViewModel(loadSerieDetailUseCase: loadSerieDetailUseCase)
        return SerieDetailView(viewModel: serieDetailViewModel)
    }
}
