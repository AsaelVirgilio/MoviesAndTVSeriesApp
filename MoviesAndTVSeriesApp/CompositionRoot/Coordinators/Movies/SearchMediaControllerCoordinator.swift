//
//  SearchMediaControllerCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import UIKit

protocol SearchMediaControllerCoordinatorDelegate: AnyObject {
    func didFinishSearch()
}

final class SearchMediaControllerCoordinator: CoordinatorType {
    
    var navigationController: NavigationType
    private var factory: SearchMediaControllerFactory
    private weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         factory: SearchMediaControllerFactory,
         parentCoordinator: ParentCoordinator
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let controller = factory.makeSearchMediaController(coordinator: self)
        controller.navigationItem.searchController = createSearchBar(controller: controller)
        navigationController.pushViewController(controller, animated: true) {
            [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
    
    private func createSearchBar(controller: UIViewController) -> UISearchController {
        let bar = UISearchController()
        bar.obscuresBackgroundDuringPresentation = false
        bar.searchBar.sizeToFit()
        bar.searchBar.delegate = controller as? any UISearchBarDelegate
        return bar
    }
}

extension SearchMediaControllerCoordinator: SearchMediaSearchControllerCoordinator {
    
    func sendToSearch(searchInfo: [String : Any]) {
        let searchMediaController = factory.makeSearchMovieCoordinator(navigation: navigationController, parentCoordinator: self, searchInfo: searchInfo)
        addChildCoordinatorStar(searchMediaController)
    }
    
}

extension SearchMediaControllerCoordinator: ParentCoordinator {}
