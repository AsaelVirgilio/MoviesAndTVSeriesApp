//
//  LoadSeriesGenresUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import Foundation

protocol LoadSeriesGenresUseCaseType {
    func execute() async -> Result<[SeriesGenres], Error>
}

struct LoadSeriesGenresUseCase: LoadSeriesGenresUseCaseType {
    private(set) var seriesGenresRepository: SeriesGenresRepositoryType
    
    func execute() async -> Result<[SeriesGenres], Error> {
        do {
            let genres = try await seriesGenresRepository.fetchSeriesGenres()
            return .success(genres)
        }
        catch {
            return .failure(error)
        }
    }
}
