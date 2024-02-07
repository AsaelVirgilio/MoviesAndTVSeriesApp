//
//  SearchMovieCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import UIKit

protocol searchMovieCoordinatorDelegate: AnyObject {
    func didFinishSearchMovie()
}

final class SearchMovieCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var factory: SearchMovieFactoryType
    private weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         factory: SearchMovieFactoryType,
         parentCoordinator: ParentCoordinator
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let controller = factory.makeSearchMovieFactory(coordinator: self)
        let genre = factory.dicInfo["key"] as? String ?? ""
        controller.title = "Results of: \(genre)"
        navigationController.pushViewController(controller, animated: true) {
            [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
    
}
extension SearchMovieCoordinator: SearchMediaViewControllerCoordinator {
    
    func didSelectCell(movie: SearchResults) {
        //goto detail de search
    }

}

extension SearchMovieCoordinator: ParentCoordinator {}
