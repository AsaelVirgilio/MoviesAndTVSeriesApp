//
//  SeriesListViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import Foundation

final class SeriesListViewModel: ObservableObject {
    
    private var listUseCase: LoadSeriesListUseCaseType
    @Published var series: [Serie] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    init(
        listUseCase: LoadSeriesListUseCaseType
    ) {
        self.listUseCase = listUseCase
    }
    
    func onAppear() {
        showLoadingSpinner = true
        
        Task {
            let result = await self.listUseCase.execute()
            
            switch result {
                
            case .success(let serie):
                Task {
                    @MainActor in
                    showLoadingSpinner = false
                    self.series = serie
                }
                
            case .failure(let error):
                Task { @MainActor in
                    showLoadingSpinner = false
                    showErrorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
}
