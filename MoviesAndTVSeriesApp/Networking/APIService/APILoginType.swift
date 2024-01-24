//
//  APILoginType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

protocol APILoginType {
    func validateCredential(credential: UserCredential) async -> Result<UserDTO, LoginError>
}
