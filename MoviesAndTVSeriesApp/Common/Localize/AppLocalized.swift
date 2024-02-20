//
//  AppLocalized.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Foundation

struct AppLocalized {
    static let error = "error"
    static let okButton = "Accept"
    static let alertErrorTitle = "Error"
    
    static let phUsername = "Username"
    static let phPassword = "Password"
    static let loginBtn = "Login"
    static let biometricBtn = "Biometric"
    static let invalidCredential = "Please verify the username and password format"
    
    static let allGenresId = 123123
    static let allMoviesGenresName = "All Movies"
    static let allSeriesGenresName = "All Series"
    static let moviesTapTitle = "Movies"
    static let seriesTapTitle = "TV Series"
    static let moviesTapIcon = "camara_2x"
    static let seriesTapIcon = "television_2x"
    
    static func imagesURLPath(path: String) -> String {
        "https://image.tmdb.org/t/p/w500\(path)"
    }
    static func videosPath(key: String) -> String {
        "https://www.youtube.com/watch?v=\(key)"
    }
}

