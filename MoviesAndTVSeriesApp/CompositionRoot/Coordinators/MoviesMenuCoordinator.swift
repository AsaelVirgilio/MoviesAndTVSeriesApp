//
//  MoviesMenuCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import UIKit
protocol MoviesMenuCoordinatorDelegate: AnyObject {
    func didTapLoguot()
}

final class MoviesMenuCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var moviesMenuFactory: MoviesMenuFactoryType
    
    init(navigationController: NavigationType,
         moviesMenuFactory: MoviesMenuFactoryType
    ) {
        self.navigationController = navigationController
        self.moviesMenuFactory = moviesMenuFactory
    }
    
    func start() {
        let controller = moviesMenuFactory.makeModule(coordinator: self)
        navigationController.pushViewController(controller, animated: true)
        moviesMenuFactory.makeTabBarItem(navigation: navigationController)
    }
}

extension MoviesMenuCoordinator: MoviesMenuViewControllerCoordinator {
    func selectedMovieGenreCell(genre: ItemMoviesGenresViewModel) {
        print("------> Movies genre selected \(genre)")
    }
    
}
