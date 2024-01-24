//
//  LoginRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

struct LoginRepository: LoginRepositoryType {
    let apiLoginService: APILoginType
    
    init(apiLoginService: APILoginType) {
        self.apiLoginService = apiLoginService
    }
    
    func fetchUser(credential: UserCredential) async -> Result<UserDTO, LoginError> {
        await apiLoginService.validateCredential(credential: credential)
    }
}
