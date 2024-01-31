//
//  VideoTrailerUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

protocol LoadVideoTrailerUseCaseType {
    func execute() async -> Result<[Video], Error>
}

struct LoadVideoTrailerUseCase: LoadVideoTrailerUseCaseType {
    
    private var videoTrailerRepository: VideoTrailerRepositoryType
    
    init(videoTrailerRepository: VideoTrailerRepositoryType) {
        self.videoTrailerRepository = videoTrailerRepository
    }
    
    func execute() async -> Result<[Video], Error> {
        do{
            let repositoryResult = try await videoTrailerRepository.fetchVideoTrailer()
            return .success(repositoryResult)
        }catch {
            return .failure(error)
        }
    }
}
