//
//  LoadMoviesGenresUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Foundation

protocol LoadMoviesGenresUseCaseType {
    func execute() async -> Result<[MGenre], Error>
}

struct LoadMoviesGenresUseCase: LoadMoviesGenresUseCaseType {
    let moviesGenresRepository: MoviesGenresRespositoryType
    
    init(moviesGenresRepository: MoviesGenresRespositoryType) {
        self.moviesGenresRepository = moviesGenresRepository
    }
    
    func execute() async -> Result<[MGenre], Error> {
        do {
            let result = try await moviesGenresRepository.fetchMovies()
            return .success(result)
        } catch {
            return .failure(error)
        }
        
    }
}
