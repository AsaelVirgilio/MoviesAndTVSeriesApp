//
//  PersonDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

struct PersonDetail {

    let adult: Bool
    let biography: String?
    let birthday: String?
    let id: Int
    let knownForDepartment: String
    let name: String
    let placeOfBirth: String?
    let popularity: Double
    let profilePath: String?
    
}

extension PersonDetailDTO {
    func toDomain() ->  PersonDetail{
        return PersonDetail(
            adult: self.adult,
            biography: self.biography,
            birthday: self.birthday,
            id: self.id,
            knownForDepartment: self.knownForDepartment,
            name: self.name,
            placeOfBirth: self.placeOfBirth,
            popularity: self.popularity,
            profilePath: self.profilePath
        )
    }
}
