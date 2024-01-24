//
//  LoginError.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

enum LoginError: Error {
    case invalidCredentials
    case genericLoginError
}

extension LoginError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
            
        case .invalidCredentials:
            return NSLocalizedString("Invalid Credentials", comment: "The user or password is invalid")
        case .genericLoginError:
            return NSLocalizedString("Unknow Error", comment: "An error has ocurred")
        }
    }
    
    
}
