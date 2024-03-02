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
    private var numElements: Int = 1
    var repositoryResult: [SearchResults] = []
    var filteredResult: [SearchResults] = []
    
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
            let results = response.results
            let numPages = response.pages
            
            if results.count > 0 {
                    
                repositoryResult = results
                
                if numPages > 1 {
                    
                    while pageNum < numPages {
                        pageNum += 1
                        let repository = try await searchMediaRepository.fetchSearchMediaResults(pageNum: pageNum)
                        let filtered = repository.results.filter { $0.genreIDS?.contains(idGenre) as? Bool ?? false }
                        filteredResult.append(contentsOf: filtered)
                        print("----> pageNum \(pageNum) -- paginas \(numPages) -- elements \(results.count) -- filtered \(filteredResult.count)")
                    }
                }
            } else {
                //no hay coincidencias
                print("----> Sin coincidencias")
            }
            repositoryResult.append(contentsOf: filteredResult)
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
