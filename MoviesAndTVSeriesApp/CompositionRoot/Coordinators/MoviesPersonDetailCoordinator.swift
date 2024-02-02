//
//  MoviesPersonDetailCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

protocol MoviesPersonDetailCoordinatorDelegate: AnyObject {
    func didSelectPhoto(person: Int)
}

final class MoviesPersonDetailCoordinator: CoordinatorType{
    var navigationController: NavigationType
    private var detailPersonFactory: MoviesPersonDetailFactory
    private weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         detailPersonFactory: MoviesPersonDetailFactory,
         parentCoordinator: ParentCoordinator? = nil
    ) {
        self.navigationController = navigationController
        self.detailPersonFactory = detailPersonFactory
        self.parentCoordinator = parentCoordinator
    }
    func start() {
        let controller = detailPersonFactory.makeMoviesPersonDetailModule(coordinator: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(controller, animated: true) { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
    
}

extension MoviesPersonDetailCoordinator: PersonDetailViewControllerCoordinator {
    func didSelectPhoto(photoPath: [String]) {
        print("----> Photo Selected \(photoPath)")
        let coordinator = detailPersonFactory.makeSelectedPhotoModule(navigation: navigationController, photoPath: photoPath, coordinator: self)
        
        addChildCoordinatorStar(coordinator)
    }
    
}
extension MoviesPersonDetailCoordinator: ParentCoordinator {}
