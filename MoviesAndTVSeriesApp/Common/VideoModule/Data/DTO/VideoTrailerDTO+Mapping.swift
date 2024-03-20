//
//  VideoTrailerDTO+Mapping.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

extension VideoTrailerDTO {
    func toDomain() -> [Video] {
        results.map { Video(name: $0.name,
                            key: $0.key,
                            site: $0.site,
                            size: $0.size,
                            type: $0.type,
                            official: $0.official,
                            publishedAt: $0.publishedAt,
                            id: $0.id)}
        .filter {
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
