//
//  PersonDTO.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

// MARK: - CastDTO
struct PersonDetailDTO: Codable {
    let adult: Bool
    let alsoKnownAs: [String]?
    let biography, birthday: String?
    let gender: Int
    let id: Int
    let imdbID: String?
    let knownForDepartment: String
    let name: String
    let placeOfBirth: String?
    let popularity: Double
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, gender, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}

