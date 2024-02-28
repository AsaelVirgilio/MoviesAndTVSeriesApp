//
//  SeriesListCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/02/24.
//

import UIKit
import SwiftUI

final class SeriesListCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var seriesListFactory: SeriesListFactoryType
    
    init(navigationController: NavigationType,
         seriesListFactory: SeriesListFactoryType
    ) {
        self.navigationController = navigationController
        self.seriesListFactory = seriesListFactory
    }
    
    func start() {
        let holder = NavStackHolder()
        let controller = seriesListFactory.makeModule(holder: holder)
        navigationController.pushViewController(controller.viewController, animated: true)
    }
    
}
