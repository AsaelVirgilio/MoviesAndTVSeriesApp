//
//  LoadFilteredMoviesUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/03/24.
//

import Foundation

struct LoadFilteredMoviesUseCase: LoadMoviesUseCaseType {
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
            while repositoryResult.count < 21 {
                
                pageNum += 1
                print("-----> count \(repositoryResult.count) ---- page \(pageNum) --- genre \(idGenre)")
                
                repositoryResult = try await moviesRepository.fetchMovies(pageNum: pageNum)
                repositoryResult.append(contentsOf: repositoryResult.filter { $0.genreIDS.contains(idGenre)})
                
            }
            
            return .success(repositoryResult)
            
        }catch {
            return .failure(error)
        }
    }
}
