//
//  SeriesMenuCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit
import SwiftUI

final class SeriesMenuCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var seriesFactory: SeriesMenuFactoryType
    var childCoordinators: [CoordinatorType] = []
    
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

extension SeriesMenuCoordinator: SeriesGenresCollectionCoordinator {
    func selectedSerieGenreCell(genre: ItemSeriesGenresViewModel) {
        let seriesListCoordinator = seriesFactory.makeSeriesListCoordinator(navigation: navigationController, genre: genre, parentCoordinator: self)
        addChildCoordinatorStar(seriesListCoordinator)
    }
}

extension SeriesMenuCoordinator: ParentCoordinator {}
