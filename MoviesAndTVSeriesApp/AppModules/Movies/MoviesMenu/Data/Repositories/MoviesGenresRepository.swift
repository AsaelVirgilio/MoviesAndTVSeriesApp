//
//  MoviesRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//
import Foundation

struct MoviesGenresRepository: MoviesGenresRespositoryType {
    private(set) var remoteService: APIClientServiceType
    private(set) var url: String
    
    func fetchMovies() async throws -> [MGenre] {
        
        let url = URL(string: url)
        let result = try await remoteService.request(url: url, type: MoviesGenresDTO.self)
        
        return result.toDomain()
    }
}
