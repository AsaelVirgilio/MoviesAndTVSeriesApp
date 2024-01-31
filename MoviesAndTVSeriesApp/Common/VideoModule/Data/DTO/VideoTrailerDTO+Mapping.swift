//
//  VideoTrailerDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

extension VideoTrailerDTO {
    func toDomain() -> [Video] {
        results.filter {
            $0.type == VideoTrailerDTO.TypeVideo.teaser.rawValue
            ||
            $0.type == VideoTrailerDTO.TypeVideo.trailer.rawValue
        }
    }
}

extension VideoTrailerDTO {
    
    enum TypeVideo: String {
        case teaser = "Teaser"
        case trailer = "Trailer"
        case behindScenes = "Behind the Scenes"
        case featurette = "Featurette"
        case clip = "Clip"
        
    }
}
