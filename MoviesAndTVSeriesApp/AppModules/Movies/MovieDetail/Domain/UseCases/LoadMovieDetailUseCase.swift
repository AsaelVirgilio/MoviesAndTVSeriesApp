//
//  LoadMovieDetailUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import Foundation

protocol LoadMovieDetailUseCaseType {
    func execute() async -> Result<MovieDetail, Error>
}

struct LoadMovieDetailUseCase: LoadMovieDetailUseCaseType {
    private(set) var movieDetailRepository: MovieDetailRepositoryType
    private(set) var movie: Movie
    
    func execute() async -> Result<MovieDetail, Error> {
        
        let movieDetail = await movieDetailRepository.fetchMovieDetail(movie: movie)
        return .success(movieDetail)
    }
}
