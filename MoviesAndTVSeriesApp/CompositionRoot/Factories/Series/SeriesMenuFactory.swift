//
//  SeriesMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit

protocol SeriesMenuFactoryType{
    func makeModule(coordinator: SeriesMenuCoordinator) -> UIViewController
    func makeTabBarItem(navigation: NavigationType)
    func makeSeriesListCoordinator(navigation: NavigationType,
                                   genre: ItemSeriesGenresViewModel,
                                   parentCoordinator: ParentCoordinator) -> CoordinatorType
}

struct SeriesMenuFactory: SeriesMenuFactoryType {
    
    
    let appDIContainer: AppDIContainer?
    
    func makeModule(coordinator: SeriesMenuCoordinator) -> UIViewController {
        
        let apiClient = APIClientService()
        let seriesGenresRepository = SeriesGenresRepository(remoteService: apiClient)
        let loadSeriesGenresUseCase = LoadSeriesGenresUseCase(seriesGenresRepository: seriesGenresRepository)
        let viewModel = SeriesGenresViewModel(
            loadSeriesGenresUseCase: loadSeriesGenresUseCase
        )
        let controller = SeriesGenresCollection(
            collectionViewLayout: makeLayout(),
            viewModel: viewModel,
            coordinator: coordinator
        )
        controller.navigationItem.title = AppLocalized.seriesTapTitle
        return controller
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - ViewValues.doublePadding ) / ViewValues.multiplierTwo
        let layoutHeight = (ViewValues.widthScreen - ViewValues.doublePadding ) / ViewValues.multiplierTwo
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        return layout
    }
    func makeTabBarItem(navigation: NavigationType) {
        makeItemHomeMenu(navigation: navigation, title: AppLocalized.seriesTapTitle, image: AppLocalized.seriesTapIcon)
    }
    
    func makeSeriesListCoordinator(navigation: NavigationType, genre: ItemSeriesGenresViewModel, parentCoordinator: ParentCoordinator) -> CoordinatorType {
        let factory = SeriesListFactory(genreItem: genre)
        return SeriesListCoordinator(navigationController: navigation, seriesListFactory: factory)
    }
}

extension SeriesMenuFactory: ItemHomeMenuFactory{}
