//
//  HomeMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

struct HomeMenuFactory {
    
    let appDIContainer: AppDIContainer?
    
    func makeHomeMenuController() -> UITabBarController {
        let homeMenuController = HomeMenuController()
        return homeMenuController
    }
    
    func makeChildCoordinators() -> [CoordinatorType] {
        let moviesMenuCoordinator = makeMoviesMenuCoordinator()
        let seriesMenuCoordinator = makeSeriesMenuCoordinator()
        
        return [moviesMenuCoordinator, seriesMenuCoordinator]
    }
    
    func makeMoviesMenuCoordinator() -> CoordinatorType {
        let moviesMenuFactory = MoviesMenuFactory(appDIContainer: appDIContainer)
        let navigation = Navigation(rootViewController: UINavigationController())
        return MoviesMenuCoordinator(navigationController: navigation, moviesMenuFactory: moviesMenuFactory)
    }
    
    func makeSeriesMenuCoordinator() -> CoordinatorType {
        let seriesMenuFactory = SeriesMenuFactory(appDIContainer: appDIContainer)
        let navigation = Navigation(rootViewController: UINavigationController())
        return SeriesMenuCoordinator(navigationController: navigation, seriesFactory: seriesMenuFactory)
    }
}
