//
//  LoadFilteredSearchMediaUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/03/24.
//

import Foundation

struct LoadFilteredSearchMediaUseCase: LoadSearchMediaUseCaseType {
    
    private(set) var searchMediaRepository: SearchMediaRepositoryType
    private(set) var pageNum: Int
    private(set) var idGenre: Int
    var repositoryResult: [SearchResults] = []
    
    init(idGenre: Int,
         searchMediaRepository: SearchMediaRepositoryType,
         pageNum: Int) {
        self.idGenre = idGenre
        self.searchMediaRepository = searchMediaRepository
        self.pageNum = pageNum
    }
    
    mutating func execute() async -> Result<[SearchResults], Error>{
        do {
            pageNum += 1
            let response = try await searchMediaRepository.fetchSearchMediaResults(pageNum: pageNum)
            
            repositoryResult = response.results
            
            while pageNum < response.pages {
                pageNum += 1
                let repository = try await searchMediaRepository.fetchSearchMediaResults(pageNum: pageNum)
                let filtered = repository.results.filter { $0.genreIDS?.contains(idGenre) as? Bool ?? false }
                repositoryResult.append(contentsOf: filtered)
            }
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
