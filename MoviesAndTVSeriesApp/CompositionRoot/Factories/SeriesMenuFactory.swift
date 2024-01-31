//
//  SeriesMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit
import Combine

protocol SeriesMenuFactoryType{
    func makeModule(coordinator: LoginViewController2Coordinator) -> UIViewController
    func makeTabBarItem(navigation: NavigationType)
}

struct SeriesMenuFactory: SeriesMenuFactoryType, LoginViewController2Coordinator {
    let appDIContainer: AppDIContainer?
    
    func makeModule(coordinator: LoginViewController2Coordinator) -> UIViewController {
        let controller = LoginViewController2(coordinator: self)
        return controller
    }
    func makeTabBarItem(navigation: NavigationType) {
        makeItemHomeMenu(navigation: navigation, title: AppLocalized.seriesTapTitle, image: AppLocalized.seriesTapIcon)

    }
}

extension SeriesMenuFactory: ItemHomeMenuFactory{}
