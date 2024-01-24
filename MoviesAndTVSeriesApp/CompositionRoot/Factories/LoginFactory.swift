//
//  LoginFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit
import Combine

protocol LoginFactoryType {
    func makeLoginViewController(coordinator: LoginViewControllerCoordinator) -> UIViewController
}

struct LoginFactory: LoginFactoryType {
    let appDIContainer: AppDIContainer?
    
    func makeLoginViewController(coordinator: LoginViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiLoginService = APILogin()
        let loginRepository = LoginRepository(apiLoginService: apiLoginService)
        let loginUseCase = LoginUseCase(loginRepository: loginRepository)
        let loginViewModel = LoginViewModel(state: state, loginUseCase: loginUseCase, logInAuth: appDIContainer?.auth)
        let controller = LoginViewController(coordinator: coordinator, viewModel: loginViewModel)
        return controller
    }
    
}
