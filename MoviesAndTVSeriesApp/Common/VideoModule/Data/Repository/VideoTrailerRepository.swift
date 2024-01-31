//
//  VideoTrailerRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

struct VideoTrailerRepository: VideoTrailerRepositoryType {
    private(set) var remoteService: APIClientServiceType
    private(set) var url: String
    
    func fetchVideoTrailer() async throws -> [Video] {
        let url = URL(string: url)
        
        let videos = try await remoteService.request(url: url, type: VideoTrailerDTO.self)
        
        return videos.toDomain()
    }
}
