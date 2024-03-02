//
//  LoadMoviesUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

protocol LoadMoviesUseCaseType {
    mutating func execute() async -> Result<[Movie],Error>
}

struct LoadMoviesUseCase: LoadMoviesUseCaseType {
    private var moviesRepository: MoviesRepositoryType
    private var pageNum: Int
    
    var repositoryResult: [Movie] = []
    
    init(moviesRepository: MoviesRepositoryType,
         pageNum: Int
    ) {
        self.moviesRepository = moviesRepository
        self.pageNum = pageNum
    }
    
    mutating func execute() async -> Result<[Movie], Error> {
        do {
            
            pageNum += 1
            repositoryResult = try await moviesRepository.fetchMovies(pageNum: pageNum)
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
