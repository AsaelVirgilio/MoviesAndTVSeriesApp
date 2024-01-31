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
    private weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigation: NavigationType,
         moviesFactory: MoviesListFactoryType,
         parentCoordinator: ParentCoordinator
    ) {
        self.navigationController = navigation
        self.factory = moviesFactory
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let controller = factory.makeMoviesListModule(coordinator: self)
        navigationController.pushViewController(controller, animated: true) {
            [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
}

extension MoviesListCoordinator: MoviesViewControllerCoordinator {
    
    func didSelectCell(movie: Movie) {
        let movieDetailCoordinator = factory.makeMovieDetailCoordinator(navigation: navigationController, movie: movie, parentCoordinator: self)
        addChildCoordinatorStar(movieDetailCoordinator)
    }
    
}

extension MoviesListCoordinator: ParentCoordinator {}
