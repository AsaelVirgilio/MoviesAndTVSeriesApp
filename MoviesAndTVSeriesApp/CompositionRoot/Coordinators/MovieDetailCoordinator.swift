//
//  MovieDetailCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import UIKit

protocol MovieDetailCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class MovieDetailCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var factoryDetail: MovieDetailFactoryType
    private weak var parentCoordinator: ParentCoordinator?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         factoryDetail: MovieDetailFactoryType,
         parentCoordinator: ParentCoordinator?) {
        self.navigationController = navigationController
        self.factoryDetail = factoryDetail
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let controller = factoryDetail.makeMovieDetailModule(coordinator: self)
        navigationController.pushViewController(controller, animated: true) {
            [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
        
    }
    
    
}

extension MovieDetailCoordinator: MovieDetailViewControllerCoordinator {

    //MARK: - VideoTrailerViewControllerCoordinator
    func didSelectExit() {
        print("Exit detail")
    }
    
    //MARK: - CastViewControllerCoordinator
    func didSelectPersonCell(itemCastViewModel: ItemCastViewModel) {
        print("Person selected \(itemCastViewModel.originalName)")
        let moviesPersonCoordinator = factoryDetail.makeMoviesPersonDetailCoordinator(
            navigation: navigationController,
            itemCastViewModel: itemCastViewModel,
            coordinator: self
        )
        addChildCoordinatorStar(moviesPersonCoordinator)
    }
}

extension MovieDetailCoordinator: ParentCoordinator {}
