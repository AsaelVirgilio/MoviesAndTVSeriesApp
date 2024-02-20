//
//  MoviesMenuCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import UIKit

final class MoviesMenuCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var moviesMenuFactory: MoviesMenuFactoryType
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         moviesMenuFactory: MoviesMenuFactoryType
    ) {
        self.navigationController = navigationController
        self.moviesMenuFactory = moviesMenuFactory
    }
    
    func start() {
        let controller = moviesMenuFactory.makeModule(coordinator: self)
        moviesMenuFactory.makeTabBarItem(navigation: navigationController)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MoviesMenuCoordinator: MoviesMenuViewControllerCoordinator {
    
    func selectedMovieGenreCell(genre: ItemMoviesGenresViewModel) {
        
        let moviesListCoordinator = moviesMenuFactory.makeMoviesListCoordinator(navigation: navigationController, genre: genre, parentCoordinator: self)
        addChildCoordinatorStar(moviesListCoordinator)
   
    }
}

extension MoviesMenuCoordinator: ParentCoordinator { }

