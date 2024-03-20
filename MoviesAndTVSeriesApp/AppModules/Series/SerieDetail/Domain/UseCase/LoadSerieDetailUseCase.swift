//
//  LoadSerieDetailUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 14/03/24.
//

import Foundation
 
protocol LoadSerieDetailUseCaseType {
    func execute() -> SerieDetail?
}

struct LoadSerieDetailUseCase: LoadSerieDetailUseCaseType {
    private(set) var serieDetail: SerieDetail?
    
    func execute() -> SerieDetail? {
        serieDetail
    }
    
}
