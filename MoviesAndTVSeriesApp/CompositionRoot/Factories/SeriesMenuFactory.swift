//
//  SeriesMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit
import Combine

protocol SeriesMenuFactoryType{
    func makeModule(holder: NavStackHolder) -> SeriesGenresViewController
    func makeTabBarItem(navigation: NavigationType)
}

struct SeriesMenuFactory: SeriesMenuFactoryType {
    let appDIContainer: AppDIContainer?
    
    func makeModule(holder: NavStackHolder) -> SeriesGenresViewController {
        
        let apiClient = APIClientService()
        let seriesGenresRepository = SeriesGenresRepository(remoteService: apiClient)
        let loadSeriesGenresUseCase = LoadSeriesGenresUseCase(seriesGenresRepository: seriesGenresRepository)
        let viewModel = SeriesGenresViewModel(
            loadSeriesGenresUseCase: loadSeriesGenresUseCase
        )
        let controller = SeriesGenresViewController(
            holder: holder,
            viewModel: viewModel)
        return controller
    }
    func makeTabBarItem(navigation: NavigationType) {
        makeItemHomeMenu(navigation: navigation, title: AppLocalized.seriesTapTitle, image: AppLocalized.seriesTapIcon)
    }
}

extension SeriesMenuFactory: ItemHomeMenuFactory{}
