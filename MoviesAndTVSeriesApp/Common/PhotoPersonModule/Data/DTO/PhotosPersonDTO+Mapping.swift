//
//  PhotosPersonDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

import Foundation

extension PhotosPersonDTO {
    
    func toDomain() -> [Profile] {
        
        profiles.filter { $0.filePath != "" }
        
    }
    
}
