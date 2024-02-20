//
//  MoviesListFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import UIKit
import Combine

protocol MoviesListFactoryType {
    func makeMoviesListModule(coordinator: MoviesViewControllerCoordinator) -> UIViewController
    func makeMovieDetailCoordinator(navigation: NavigationType,
                                    movie: Movie,
                                    parentCoordinator: ParentCoordinator) -> CoordinatorType
    
    func makeSearchMediaController(navigation: NavigationType,
                                          parentCoordinator: ParentCoordinator) -> CoordinatorType
}

struct MoviesListFactory: ItemHomeMenuFactory, MoviesListFactoryType {
    
    let pageNum: Int
    let itemMoviesGenresViewModel: ItemMoviesGenresViewModel
    
    func makeMoviesListModule(coordinator: MoviesViewControllerCoordinator) -> UIViewController {
        
        let state = PassthroughSubject<StateController, Never>()
        let urlString = PathLocalized.createURL(path: .moviesTrending, id: pageNum)
        let url = URL(string: urlString)
        let apiClient = APIClientService()
        
        let localDataImageService = LocalDataImageService()
        let imageDataRepository = 
        ImageDataRepository(
            remoteDataService: apiClient,
            localDataCache: localDataImageService
        )
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let lastPageValidationUseCase = LastPageValidationUseCase()
        let moviesRepository = 
        MoviesRepository(
            remoteService: apiClient,
            url: url,
            idGenre: itemMoviesGenresViewModel.idGenre
        )
        let loadMoviesUseCase = LoadMoviesUseCase(moviesRepository: moviesRepository, pageNum: 0)
        let moviesViewModel = MoviesViewModel(state: state, loadMoviesUseCase: loadMoviesUseCase, lastPageValidationUseCase: lastPageValidationUseCase, imageDataUseCase: imageDataUseCase)
        let controller = MoviesViewController(viewModel: moviesViewModel, coordinator: coordinator)
        controller.title = "\(itemMoviesGenresViewModel.name)"
        return controller
    }
    
    func makeMovieDetailCoordinator(navigation: NavigationType, movie: Movie, parentCoordinator: ParentCoordinator) -> CoordinatorType {
        
        let factory = MovieDetailFactory(movie: movie)
        
        return MovieDetailCoordinator(navigationController: navigation,
                                      factoryDetail: factory,
                                      parentCoordinator: parentCoordinator)
    }
    
    func makeSearchMediaController(navigation: NavigationType, parentCoordinator: ParentCoordinator) -> CoordinatorType {
        let factory = SearchMediaControllerFactory(itemGenre: itemMoviesGenresViewModel)
        let controller = SearchMediaControllerCoordinator(navigationController: navigation, factory: factory, parentCoordinator: parentCoordinator)
        return controller
    }
}

