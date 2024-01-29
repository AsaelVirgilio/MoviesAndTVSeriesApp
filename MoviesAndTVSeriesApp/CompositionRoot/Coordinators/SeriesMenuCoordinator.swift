//
//  SeriesMenuCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit


final class SeriesMenuCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var seriesFactory: SeriesMenuFactoryType
    
    init(navigationController: NavigationType,
         seriesFactory: SeriesMenuFactoryType) {
        self.navigationController = navigationController
        self.seriesFactory = seriesFactory
    }
    func start() {
        let controller = seriesFactory.makeModule(coordinator: self)
        navigationController.pushViewController(controller, animated: false)
        seriesFactory.makeTabBarItem(navigation: navigationController)
    }

}
extension SeriesMenuCoordinator: LoginViewController2Coordinator {}
