//
//  AppFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit

protocol AppFactoryType {
    
    func makeLoginCoordinator(
      navigation: NavigationType,
      delegate: LoginCoordinatorDelegate
    ) -> CoordinatorType
    
    func makeHomeMenuCoordinator(
      navigation: NavigationType,
      delegate: HomeMenuCoordinatorDelegate
    ) -> CoordinatorType
}

struct AppFactory: AppFactoryType {
    let appDIContainer: AppDIContainer?
    
    func makeLoginCoordinator(navigation: NavigationType, delegate: LoginCoordinatorDelegate) -> CoordinatorType {
        let loginFactory = LoginFactory(appDIContainer: appDIContainer)
        return LoginCoordinator(navigationController: navigation, loginFactory: loginFactory, delegate: delegate)
    }
    
    func makeHomeMenuCoordinator(navigation: NavigationType, delegate: HomeMenuCoordinatorDelegate) -> CoordinatorType {
        let factoryHomeMenu = HomeMenuFactory(appDIContainer: appDIContainer)
        return HomeMenuCoordinator(navigationController: navigation, homeMenuFactory: factoryHomeMenu, delegate: delegate)
    }
    
}
