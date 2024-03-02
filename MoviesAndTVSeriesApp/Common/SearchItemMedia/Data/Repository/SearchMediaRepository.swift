//
//  SearchMediaRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//
import Foundation

struct SearchMediaRepository: SearchMediaRepositoryType {
    private(set) var apiService: APIClientServiceType
    private(set) var keyword: String
    
    func fetchSearchMediaResults(pageNum: Int) async throws -> (pages: Int, results: [SearchResults]) {
        let urlString: String = PathLocalized.createURLSearch(path: .searchMovie, keyword: keyword, page: pageNum)
        let url = URL(string: urlString)
        let result = try await apiService.request(url: url, type: SearchMediaDTO.self)
        return result.toDomain()
        
    }
    
}
