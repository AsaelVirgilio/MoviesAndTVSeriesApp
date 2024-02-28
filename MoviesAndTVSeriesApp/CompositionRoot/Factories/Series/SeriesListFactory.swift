//
//  SeriesListFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import Foundation

class SeriesListFactory: CreateSeriesListView {
    
    func create(idGenre: Int) -> SeriesListView {
        
        let apiClient = APIClientService()
        let remoteImageDataService = APIClientService()
        let localDataImageService = LocalDataImageService()
        let seriesListRepository = SeriesListRepository(apiService: apiClient, idGenre: idGenre)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: ImageDataRepository(remoteDataService: remoteImageDataService, localDataCache: localDataImageService))
        let loadSeriesListUseCase = LoadSeriesListUseCase(repositoryList: seriesListRepository)
        let seriesListViewModel = SeriesListViewModel(listUseCase: loadSeriesListUseCase)
        return SeriesListView(viewModel: seriesListViewModel, imageDataUseCase: imageDataUseCase)
    }
}
