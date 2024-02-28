//
//  LoadSeriesListUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

protocol LoadSeriesListUseCaseType {
    mutating func execute() async -> Result<[Serie], Error>
}

struct LoadSeriesListUseCase: LoadSeriesListUseCaseType {
    
    private(set) var repositoryList: SeriesListRepositoryType
    private(set) var pageNum: Int = 0
    var repositoryResult: [Serie] = []
    
    init(repositoryList: SeriesListRepositoryType
    ) {
        self.repositoryList = repositoryList
    }
    
    mutating func execute() async -> Result<[Serie], Error> {
        do {
            pageNum += 1
            repositoryResult = try await repositoryList.fetchFilteredSeries(pageNum: pageNum)
            
            while repositoryResult.count <= 20 {
                
                if pageNum == 1 {
                    repositoryResult.removeAll()
                }
                
                pageNum += 1
                let result = try await repositoryList.fetchFilteredSeries(pageNum: pageNum)
                
                repositoryResult.append(contentsOf: result)
                
            }
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
