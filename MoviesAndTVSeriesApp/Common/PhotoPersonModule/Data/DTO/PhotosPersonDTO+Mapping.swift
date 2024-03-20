//
//  PhotosPersonDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

import Foundation

extension PhotosPersonDTO {
    
    func toDomain() -> [PhotosPerson] {
        
        profiles
            .map { PhotosPerson(aspectRatio: $0.aspectRatio,
                                height: $0.height,
                                filePath: $0.filePath,
                                width: $0.width)
            }
            .filter { $0.filePath != "" }
        
    }
    
}
