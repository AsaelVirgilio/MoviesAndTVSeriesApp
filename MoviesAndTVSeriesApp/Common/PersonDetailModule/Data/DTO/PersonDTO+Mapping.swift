//
//  PersonDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

extension PersonDetailDTO {
    func toDomain() ->  PersonDetail{
        return PersonDetail(
            biography: self.biography,
            birthday: self.birthday,
            id: self.id,
            knownForDepartment: self.knownForDepartment,
            name: self.name,
            placeOfBirth: self.placeOfBirth,
            profilePath: self.profilePath
        )
    }
}
