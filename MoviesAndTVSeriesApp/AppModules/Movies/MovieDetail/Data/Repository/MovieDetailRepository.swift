//
//  MovieDetailRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

struct MovieDetailRepository: MovieDetailRepositoryType {
    
    func fetchMovieDetail(movie: Movie) async -> MovieDetail {
        
        let backdropPath = movie.backdropPath ?? ""
        
        try? await Task.sleep(nanoseconds: UInt64(0.3) * 1_000_000_000)
        
        let movieDetail =  MovieDetail(id: movie.id,
                                      backdropPath: backdropPath,
                                      originalTitle: movie.originalTitle,
                                      overview: movie.overview)
        
        return movieDetail
    }
}
