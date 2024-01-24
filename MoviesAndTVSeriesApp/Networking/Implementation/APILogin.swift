//
//  APILogin.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

struct APILogin: APILoginType {

    func validateCredential(credential: UserCredential) async -> Result<UserDTO, LoginError> {
        var result: Result<UserDTO, LoginError> = .failure(.genericLoginError)
        
        try? await Task.sleep(nanoseconds: UInt64(2.0) * 1_000_000_000)
        
        if credential.username == "Asa" && credential.password == "123" {
            let user = UserDTO(name: "Asa", lastName: "el", age: 23)
            result = .success(user)
        }
        else {
            result = .failure(.invalidCredentials)
        }
        return result
        
    }
    
    
}
