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
    
    init(navigationController: NavigationType,
         seriesFactory: SeriesMenuFactoryType) {
        self.navigationController = navigationController
        self.seriesFactory = seriesFactory
    }
    func start() {
        let holder = NavStackHolder()
        let controller = seriesFactory.makeModule(holder: holder)
        navigationController.pushViewController(controller.viewController, animated: false)
        seriesFactory.makeTabBarItem(navigation: navigationController)
    }

}
