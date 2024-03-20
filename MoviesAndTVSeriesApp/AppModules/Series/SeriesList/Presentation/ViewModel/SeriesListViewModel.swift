//
//  SeriesListViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import Foundation

class SeriesListViewModel: ObservableObject {
    
    private var listUseCase: LoadSeriesListUseCaseType
    var imageDataUseCase: ImageDataUseCaseType
    private var lastPageValidationUseCase: LastPageValidationUseCaseType

    
    @Published var series: [Serie] = []
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    
    init(lastPageValidationUseCase: LastPageValidationUseCaseType,
        imageDataUseCase: ImageDataUseCaseType,
        listUseCase: LoadSeriesListUseCaseType
    ) {
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
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
//                    checkAndLoadMoreMovies(row: 8)
                }
                
            case .failure(let error):
                Task { @MainActor in
                    showLoadingSpinner = false
                    showErrorMessage = error.localizedDescription
                }
            }
            
        }
    }
//    
//    private func checkAndLoadMoreMovies(row: Int) {
//        lastPageValidationUseCase.updateLastPage(itemsCount: series.count)
//        lastPageValidationUseCase.checkAndLoadMoreItems(row: row, actualItems: series.count, action: onAppear)
//    }
    
    
}
