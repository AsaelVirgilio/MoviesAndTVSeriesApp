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
    private var idGenre: Int
    
    var repositoryResult: [Movie] = []
    
    init(moviesRepository: MoviesRepositoryType,
         pageNum: Int,
         idGenre: Int
    ) {
        self.moviesRepository = moviesRepository
        self.pageNum = pageNum
        self.idGenre = idGenre
    }
    
    mutating func execute() async -> Result<[Movie], Error> {
        do {
            
            pageNum += 1
            repositoryResult = try await moviesRepository.fetchMovies(pageNum: pageNum)
            
            if idGenre != AppLocalized.allGenresId {
                
                if repositoryResult.count < 21 {
                    print("----> Borrando \(repositoryResult.count) elements")
                    repositoryResult.removeAll()
                }
                
                while repositoryResult.count < 21 {
                    print("-----> count \(repositoryResult.count) ---- page \(pageNum)")
                    let temp = try await moviesRepository.fetchMovies(pageNum: pageNum)
                    
                    repositoryResult.append(contentsOf: temp.filter { $0.genreIDS.contains(idGenre) } )
                    
                    pageNum += 1
                    
                }
                
            }
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
