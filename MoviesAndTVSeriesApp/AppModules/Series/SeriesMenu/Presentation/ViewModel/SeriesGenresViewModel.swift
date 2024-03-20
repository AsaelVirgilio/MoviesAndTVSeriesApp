//
//  SeriesGenresViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import Combine

//protocol SeriesGenresViewModelType: BaseViewModelType {
//    var numOfGenres: Int { get }
//    func getItemSeriesGenre(row: Int) -> ItemSeriesGenresViewModel
//}
import Foundation

class SeriesGenresViewModel: ObservableObject {
    
    private let loadSeriesGenresUseCase: LoadSeriesGenresUseCaseType
    
    private var seriesModel: [ItemSeriesGenresViewModel] = []
    @Published var genres: [ItemSeriesGenresViewModel] = []
    @Published var numberOfGenres: Int?
    @Published var showLoadingSpinner: Bool = false
    @Published var showErrorMessage: String?
    
    init(loadSeriesGenresUseCase: LoadSeriesGenresUseCaseType
    ) {
        self.loadSeriesGenresUseCase = loadSeriesGenresUseCase
    }
    
    func onAppear() {
        Task {
//            await loadSeriesGenres()
            let result = await loadSeriesGenresUseCase.execute()
            
            guard case .success(let series) = result else {
                guard case .failure(let failure) = result else {
                    // ?
                    return
                }
                handleError(error: failure)
                return
            }
            
            seriesModel = series.map{ ItemSeriesGenresViewModel(genre: $0)}
            
            let allSeries = ItemSeriesGenresViewModel(genre: SeriesGenres(id: AppLocalized.allGenresId, name: AppLocalized.allSeriesGenresName))
            
            seriesModel.insert(allSeries, at: 0)
            
            Task { @MainActor in
                genres = seriesModel
                print("-----> Number \(seriesModel.count)")
                numberOfGenres = seriesModel.count
            }
        }
    }
    
    private func handleError(error: Error?) {
        //        let message = errorMapper.map(error: error)
        Task { @MainActor in
            showLoadingSpinner = false
            showErrorMessage =  error?.localizedDescription
            
        }
    }
    
}
