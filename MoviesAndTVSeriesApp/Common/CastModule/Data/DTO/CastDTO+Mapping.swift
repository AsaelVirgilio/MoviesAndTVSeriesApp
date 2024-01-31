//
//  CastDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

extension CastDTO {
    func toDomain() -> [Person] {
        cast.filter {
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
