//
//  HomeMenuCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

protocol HomeMenuCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class HomeMenuCoordinator: CoordinatorType {
    
    var navigationController: NavigationType
    private var homeMenuFactory: HomeMenuFactory
    private weak var delegate: HomeMenuCoordinatorDelegate?
    var childCoordinators: [CoordinatorType] = []
    
    init(navigationController: NavigationType,
         homeMenuFactory: HomeMenuFactory,
         delegate: HomeMenuCoordinatorDelegate
    ) {
        self.navigationController = navigationController
        self.homeMenuFactory = homeMenuFactory
        self.delegate = delegate
    }
    
    func start() {
        let controller = homeMenuFactory.makeHomeMenuController()
        navigationController.pushViewController(controller, animated: false)
        navigationController.navigationBar.isHidden = true
        
        childCoordinators = homeMenuFactory.makeChildCoordinators(delegate: self)
        let childNavigation = childCoordinators.map {
            $0.navigationController.rootViewController
        }
        
        childCoordinators.forEach { $0.start() }
        controller.viewControllers = childNavigation
    }
}

extension HomeMenuCoordinator: MoviesMenuCoordinatorDelegate {
    func didTapLoguot() {
        print("-----> Salida de MoviesMenuCoordinator")
    }
    
    
}
