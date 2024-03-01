//
//  SeriesListRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//
import Foundation

struct SeriesListRepository: SeriesListRepositoryType {
    private(set) var apiService: APIClientServiceType
    private(set) var url: URL?
    private(set) var idGenre: Int
    
    mutating func fetchFilteredSeries(pageNum: Int) async throws -> [Serie] {

        url = URL(string: PathLocalized.createURL(path: .tvTrending, id: pageNum))
        print("----> \(url)")
        let response = try await apiService.request(url: url, type: SeriesListDTO.self)
        
        return response.toDomain(idGenre: idGenre)
    }
}
