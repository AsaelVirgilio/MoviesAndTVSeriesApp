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
    weak var delegate: MoviesMenuCoordinatorDelegate?
    var movisListCoordinator: CoordinatorType?
    
    init(navigationController: NavigationType,
         moviesMenuFactory: MoviesMenuFactoryType,
         delegate: MoviesMenuCoordinatorDelegate
    ) {
        self.navigationController = navigationController
        self.moviesMenuFactory = moviesMenuFactory
        self.delegate = delegate
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
        movisListCoordinator = moviesMenuFactory.makeMoviesListCoordinator(delegate: self, genre: genre)
        movisListCoordinator?.start()
        guard let movisListCoordinator = movisListCoordinator else { return }
        navigationController.present(movisListCoordinator.navigationController.rootViewController, animated: true)
        movisListCoordinator.navigationController.dismissNavigation = { [weak self] in
            self?.movisListCoordinator = nil
        }
    }
}

extension MoviesMenuCoordinator: MoviesListCoordinatorDelegate {
    func didFinish() {
        print("------> didFinish from MoviesListCoordinatorDelegate")
    }
    
    
}
