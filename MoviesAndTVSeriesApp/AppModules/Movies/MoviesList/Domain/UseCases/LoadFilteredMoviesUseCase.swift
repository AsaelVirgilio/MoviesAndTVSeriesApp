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
    private var numElements: Int = 1
    
    var repositoryResult: [Movie] = []
    var filteredResult: [Movie] = []
    
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
            
            filteredResult.removeAll()
            numElements = 1
            repositoryResult.removeAll()
            
            while (numElements % 20) != 0 {
                
                pageNum += 1
                
                let movies = try await moviesRepository.fetchMovies(pageNum: pageNum)
                filteredResult.append(contentsOf: movies.filter { $0.genreIDS.contains(idGenre) })
                
                numElements = filteredResult.count == 0 ? 1 : filteredResult.count
                
            }
            
            repositoryResult.append(contentsOf: filteredResult)
            return .success(filteredResult)
            
        }catch {
            return .failure(error)
        }
    }
}
