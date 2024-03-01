//
//  LoginCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinishLogin()
}

final class LoginCoordinator: CoordinatorType {
    
    var navigationController: NavigationType
    var loginFactory: LoginFactoryType
    weak var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: NavigationType,
         loginFactory: LoginFactoryType,
         delegate: LoginCoordinatorDelegate
    ) {
        self.navigationController = navigationController
        self.loginFactory = loginFactory
        self.delegate = delegate
    }
    
    func start() {
        let controller = loginFactory.makeLoginViewController(coordinator: self)
        navigationController.pushViewController(controller, animated: false)
    }
}

extension LoginCoordinator: LoginViewControllerCoordinator {
    
    func loginSuccess(user: UserDTO) {
        delegate?.didFinishLogin()
    }
}
