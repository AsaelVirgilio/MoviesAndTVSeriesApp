//
//  SelectedPhotoCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Foundation

protocol SelectedPhotoCoordinatorDelegate: AnyObject {
    func presentedPhoto()
}

final class SelectedPhotoCoordinator: CoordinatorType {
    var navigationController: NavigationType
    private var selectedPhotoFactory: SelectedPhotoFactoryType
    private weak var parentCoordinator: ParentCoordinator?
    
    init(navigationController: NavigationType,
         selectedPhotoFactory: SelectedPhotoFactoryType,
         parentCoordinator: ParentCoordinator? = nil
    ) {
        self.navigationController = navigationController
        self.selectedPhotoFactory = selectedPhotoFactory
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let controller = selectedPhotoFactory.makeSelectedPhotoModule(coordinator: self)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(controller, animated: true) { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.removeChildCoordinator(self)
        }
    }
}

extension SelectedPhotoCoordinator: SelectedPhotosPersonViewControllerCoordinator {
    func didDisapperView() {
        print("DIisapper view")
    }
}
