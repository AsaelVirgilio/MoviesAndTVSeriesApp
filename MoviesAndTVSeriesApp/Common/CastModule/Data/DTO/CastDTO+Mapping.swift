//
//  CastDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

extension CastDTO {
    func toDomain() -> [Person] {
        cast
            .map { Person(id: $0.id,
                          name: $0.name,
                          originalName: $0.originalName,
                          knownForDepartment: $0.knownForDepartment,
                          profilePath: $0.profilePath,
                          character: $0.character)
            }
            .filter {
            $0.knownForDepartment == Department.acting.rawValue
        }
    }
}

extension CastDTO {
    
    enum Department: String {
        case acting = "Acting"
        case directing = "Directing"
        case production = "Production"
        case sound = "Sound"
        case writing = "Writing"
        case costume = "Costume & Make-Up"
        case art = "Art"
        case camera = "Camera"
        case crew = "Crew"
    }
    
}
