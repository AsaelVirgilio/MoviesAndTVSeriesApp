//
//  LoadSeriesGenresUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import Foundation

protocol LoadSeriesGenresUseCaseType {
    func execute() async -> Result<[SGenre], Error>
}

struct LoadSeriesGenresUseCase: LoadSeriesGenresUseCaseType {
    private(set) var seriesGenresRepository: SeriesGenresRepositoryType
    
    func execute() async -> Result<[SGenre], Error> {
        do {
            let genres = try await seriesGenresRepository.fetchSeriesGenres()
            return .success(genres)
        }
        catch {
            return .failure(error)
        }
    }
}
