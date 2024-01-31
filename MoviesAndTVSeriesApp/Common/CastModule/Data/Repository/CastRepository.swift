//
//  CastRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

struct CastRepository: CastRepositoryType {
    private(set) var remoteService: APIClientServiceType
    private(set) var urlString: String
    
    
    func fetchCast() async throws -> [Person] {
        let url = URL(string: urlString)
        
        let cast = try await remoteService.request(url: url, type: CastDTO.self)
        
        return cast.toDomain()
    }
    
}
