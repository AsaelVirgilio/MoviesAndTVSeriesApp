//
//  SeriesGenresRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//
import Foundation

struct SeriesGenresRepository: SeriesGenresRepositoryType {
    private(set) var remoteService: APIClientService
    
    func fetchSeriesGenres() async throws -> [SGenre] {
        let url = URL(string: PathLocalized.createURL(path: .tvGenres))
        
        let series = try await remoteService.request(url: url, type: SeriesGenresDTO.self)
        
        return series.genres
    }
    
}
