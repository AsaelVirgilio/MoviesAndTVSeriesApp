//
//  LoadCastUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

protocol LoadCastUseCaseType {
    func execute() async -> Result<[Person], Error>
}

struct LoadCastUseCase: LoadCastUseCaseType {
    
    private(set) var castRepository: CastRepositoryType
    
    init(castRepository: CastRepositoryType) {
        self.castRepository = castRepository
    }
    
    func execute() async -> Result<[Person], Error> {
        
        do {
            let cast = try await castRepository.fetchCast()
            return .success(cast)
        }catch {
            return .failure(error)
        }
        
    }
}
