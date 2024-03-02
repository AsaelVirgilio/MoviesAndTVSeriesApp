//
//  MoviesRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

struct MoviesRepository: MoviesRepositoryType {
    
    private(set) var remoteService: APIClientServiceType
    private(set) var url: URL?
    
    mutating func fetchMovies(pageNum: Int) async throws -> [Movie] {
        
        url = URL(string: PathLocalized.createURL(path: .moviesTrending, id: pageNum))
        let moviesList = try await remoteService.request(url: url, type: MoviesDTO.self)
        
        return moviesList.toDomain()
        
    }
    
    
}
