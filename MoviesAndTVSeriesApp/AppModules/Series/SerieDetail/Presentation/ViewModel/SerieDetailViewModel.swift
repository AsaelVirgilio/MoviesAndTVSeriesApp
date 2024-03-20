//
//  SerieDetailViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 14/03/24.
//

import Foundation
final class SerieDetailViewModel: ObservableObject {
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    @Published var serieDetail: SerieDetail?
    
    private var loadSerieDetailUseCase: LoadSerieDetailUseCaseType
    
    init(loadSerieDetailUseCase: LoadSerieDetailUseCaseType) {
        self.loadSerieDetailUseCase = loadSerieDetailUseCase
    }
    
    func onAppear() {
        
        showLoadingSpinner = true
        
        let detail = loadSerieDetailUseCase.execute()
        
        showLoadingSpinner = false
        
        guard let detail = detail else { return showErrorMessage = "Could not to load serie detail"}
        
        serieDetail = detail
        
    }
}
