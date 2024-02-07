//
//  SearchMediaControllerFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import UIKit

protocol SearchMediaControllerFactoryType {
    func makeSearchMediaController(coordinator: SearchMediaSearchControllerCoordinator) -> UIViewController
    
    func makeSearchMovieCoordinator(navigation: NavigationType, parentCoordinator: ParentCoordinator, searchInfo: [String: Any]) -> CoordinatorType
}

struct SearchMediaControllerFactory: SearchMediaControllerFactoryType {
    
    let idGenre: Int
    
    func makeSearchMediaController(coordinator: SearchMediaSearchControllerCoordinator) -> UIViewController {
        
        let coordinator = SearchMediaSearchController(coordinator: coordinator, idGenre: idGenre)
        return coordinator
    }

    
    func makeSearchMovieCoordinator(navigation: NavigationType,
                                    parentCoordinator: ParentCoordinator,
                                    searchInfo: [String: Any]) -> CoordinatorType {
        let factory = SearchMovieFactory(dicInfo: searchInfo)
        return SearchMovieCoordinator(navigationController: navigation, factory: factory, parentCoordinator: parentCoordinator)

    }
}
