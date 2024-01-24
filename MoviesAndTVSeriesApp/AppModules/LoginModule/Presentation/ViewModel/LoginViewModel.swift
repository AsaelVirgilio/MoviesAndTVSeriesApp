//
//  LoginViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Combine
import UIKit

protocol LoginViewModelType {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
    
    func validateUser(credential: UserCredential)
    func getUser() -> UserDTO
}

final class LoginViewModel: LoginViewModelType {
    var state: PassthroughSubject<StateController, Never>
    
    private let loginUseCase: LoginUseCaseType
    var user: UserDTO?
    var logInAuth: LogInAuth?
    
    init(state: PassthroughSubject<StateController, Never>,
         loginUseCase: LoginUseCaseType,
         logInAuth: LogInAuth?
    ) {
        self.state = state
        self.loginUseCase = loginUseCase
        self.logInAuth = logInAuth
    }
    
    func viewDidLoad() {
        state.send(.loading)
    }
    
    func validateUser(credential: UserCredential) {
        Task{@MainActor in
            let result = await loginUseCase.execute(credential: credential)
            
            switch result {
            case .success(let result):
                self.user = result
                logInAuth?.logIn()
                state.send(.success)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
            
        }
    }
    
    func getUser() -> UserDTO {
        guard let user = self.user else {
            return UserDTO(name: "", lastName: "", age: 0)
        }
        return user
    }
    
}
