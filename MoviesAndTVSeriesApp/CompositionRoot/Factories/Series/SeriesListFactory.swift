//
//  SeriesListFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import Foundation

protocol SeriesListFactoryType{
    func makeModule(holder: NavStackHolder) -> SeriesListView
}

//class SeriesListFactory: CreateSeriesListView {
struct SeriesListFactory: SeriesListFactoryType {
    
//    func create(idGenre: Int) -> SeriesListView {
    var genreItem: ItemSeriesGenresViewModel
    
    func makeModule(holder: NavStackHolder) -> SeriesListView {
        
        let apiClient = APIClientService()
        let remoteImageDataService = APIClientService()
        let localDataImageService = LocalDataImageService()
        let seriesListRepository = SeriesListRepository(apiService: apiClient, idGenre: genreItem.idGenre)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: ImageDataRepository(remoteDataService: remoteImageDataService, localDataCache: localDataImageService))
        let loadSeriesListUseCase = LoadSeriesListUseCase(repositoryList: seriesListRepository)
        let seriesListViewModel = SeriesListViewModel(imageDataUseCase: imageDataUseCase, listUseCase: loadSeriesListUseCase)
        return SeriesListView(viewModel: seriesListViewModel, holder: holder)
    }
}
