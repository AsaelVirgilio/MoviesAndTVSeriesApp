//
//  LoginRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

protocol LoginRepositoryType {
    func fetchUser(credential: UserCredential) async -> Result<UserDTO, LoginError>
}
