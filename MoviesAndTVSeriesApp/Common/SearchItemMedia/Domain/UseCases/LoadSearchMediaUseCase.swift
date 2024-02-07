//
//  LoadSearchMediaUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 04/02/24.
//

import Foundation

protocol LoadSearchMediaUseCaseType {
    mutating func execute() async -> Result<[SearchResults], Error>
}

struct LoadSearchMediaUseCase: LoadSearchMediaUseCaseType {
    
    private(set) var searchMediaRepository: SearchMediaRepositoryType
    private(set) var pageNum: Int
    var repositoryResult: [SearchResults] = []
    
    init(searchMediaRepository: SearchMediaRepositoryType,
         pageNum: Int) {
        self.searchMediaRepository = searchMediaRepository
        self.pageNum = pageNum
    }
    
    
    mutating func execute() async -> Result<[SearchResults], Error>{
        do {
            pageNum += 1
            repositoryResult = try await searchMediaRepository.fetchSearchMediaResults(pageNum: pageNum)
            
            if repositoryResult.count <= 20 {
                repositoryResult.removeAll()
            }
            
            while repositoryResult.count <= 20 {
                
                pageNum += 1
                let repository = try await searchMediaRepository.fetchSearchMediaResults(pageNum: pageNum)
                repositoryResult.append(contentsOf: repository)
            }
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
