//
//  HomeMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

//protocol HomeMenuFactoryType {
//    func makeModule(coordinator: HomeMenuControllerCoordinator) -> UIViewController
//}

struct HomeMenuFactory {
    
//    let user: UserDTO
    let appDIContainer: AppDIContainer?
    
    func makeHomeMenuController() -> UITabBarController {
        let homeMenuController = HomeMenuController()
        return homeMenuController
    }
    
    func makeChildCoordinators(delegate: MoviesMenuCoordinatorDelegate) -> [CoordinatorType] {
      let moviesMenuCoordinator = makeMoviesMenuCoordinator(delegate: delegate)
      let seriesMenuCoordinator = makeSeriesMenuCoordinator()
//      let myPostCoordinator = makeMyPostCoordinator()
//      let homeCoordinator = makeHomeCoordinator()
      
      return [moviesMenuCoordinator, seriesMenuCoordinator]
    }
    
    func makeMoviesMenuCoordinator(delegate: MoviesMenuCoordinatorDelegate) -> CoordinatorType {
        
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
