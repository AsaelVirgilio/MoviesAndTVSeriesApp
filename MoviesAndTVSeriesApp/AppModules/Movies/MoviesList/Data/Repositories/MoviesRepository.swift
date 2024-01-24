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
    private(set) var idGenre: Int
    
    mutating func fetchFilteredMovies(pageNum: Int) async throws -> [Movie] {
        print("------> URL de Movies \(url)")
//        var url = URL(string: url)
        let moviesList = try await remoteService.request(url: url, type: MoviesDTO.self)
        url = URL(string: PathLocalized.createURL(path: .moviesTrending, id: pageNum))
        return moviesList.toDomain(idGenre: idGenre)
    }
    
    
}
