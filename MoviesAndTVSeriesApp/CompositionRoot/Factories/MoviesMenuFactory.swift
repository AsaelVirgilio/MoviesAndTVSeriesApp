//
//  MoviesMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import UIKit
import Combine

protocol MoviesMenuFactoryType {
    func makeModule(coordinator: MoviesMenuViewControllerCoordinator) -> UIViewController
    func makeTabBarItem(navigation: NavigationType)
    func makeMoviesListCoordinator(navigation: NavigationType,
                                   genre: ItemMoviesGenresViewModel,
                                   parentCoordinator: ParentCoordinator) -> CoordinatorType
}

struct MoviesMenuFactory: MoviesMenuFactoryType, ItemHomeMenuFactory {
    let appDIContainer: AppDIContainer?
    
    func makeModule(coordinator: MoviesMenuViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let url = PathLocalized.createURL(path: .moviesGenres)
        
        let aPIClientService = APIClientService()
        let moviesGenresRespository = MoviesGenresRepository(remoteService: aPIClientService, url: url)
        let loadMoviesGenresUseCase = LoadMoviesGenresUseCase(moviesGenresRepository: moviesGenresRespository)
        let moviesGenresViewModel = MoviesGenresViewModel(loadMoviesGenreUseCase: loadMoviesGenresUseCase, state: state)
        let controller = MoviesMenuViewController(collectionViewLayout: makeLayout(), viewModel: moviesGenresViewModel, coordinator: coordinator)

        controller.title = AppLocalized.moviesTapTitle
        return controller
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - ViewValues.doublePadding ) / ViewValues.multiplierTwo
        let layoutHeight = (ViewValues.widthScreen  - ViewValues.doublePadding ) / ViewValues.multiplierTwo
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        return layout
    }
    
    func makeTabBarItem(navigation: NavigationType) {
        makeItemHomeMenu(navigation: navigation,
                         title: AppLocalized.moviesTapTitle,
                         image: AppLocalized.moviesTapIcon
        )
    }
    
    func makeMoviesListCoordinator(navigation: NavigationType,
                                   genre: ItemMoviesGenresViewModel,
                                   parentCoordinator: ParentCoordinator) -> CoordinatorType
    {
        
        let factory = MoviesListFactory(pageNum: 1, itemMoviesGenresViewModel: genre)
        return MoviesListCoordinator(navigation: navigation,
                                     moviesFactory: factory,
                                     parentCoordinator: parentCoordinator)
    }
}


