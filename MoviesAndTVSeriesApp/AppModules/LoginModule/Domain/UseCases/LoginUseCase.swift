//
//  LoginUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

protocol LoginUseCaseType {
    func execute(credential: UserCredential) async -> Result<UserDTO, LoginError>
}

struct LoginUseCase: LoginUseCaseType {
    
    let loginRepository: LoginRepositoryType
    
    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }
    
    func execute(credential: UserCredential) async -> Result<UserDTO, LoginError> {
        let user = await loginRepository.fetchUser(credential: credential)
        
        guard let userResult = try? user.get() else {
            guard case .failure(let error) = user else {
                return .failure(.genericLoginError)
            }
            return .failure(error)
        }
        return .success(userResult)
    }
}
