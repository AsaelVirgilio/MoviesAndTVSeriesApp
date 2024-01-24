//
//  MoviesListCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import UIKit

protocol MoviesListCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class MoviesListCoordinator: CoordinatorType {
    
    var navigationController: NavigationType
    private var factory: MoviesListFactoryType
    private weak var delegate: MoviesListCoordinatorDelegate?
    
    
    init(navigation: NavigationType,
         moviesFactory: MoviesListFactoryType,
         delegate: MoviesListCoordinatorDelegate?
    ) {
        self.navigationController = navigation
        self.factory = moviesFactory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeMoviesListModule(coordinator: self)
        navigationController.viewControllers = [controller]
    }
}

extension MoviesListCoordinator: MoviesViewControllerCoordinator {
    func didSelectCell(model: ItemMoviesViewModel) {
        print("-----> Goto detail with this model \(model)")
//        navigationController.pushViewController(factory.makeMoviesListModule(coordinator: self), animated: true)
    }
    
}
