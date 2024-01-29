//
//  ItemMovieDetailViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//
import Foundation

struct ItemMovieDetailViewModel {
    private(set) var movieDetail: MovieDetail
    private(set) var dataImageUseCase: ImageDataUseCaseType
    
    var id: Int {
        movieDetail.id
    }
    
    var originalTitle: String {
        movieDetail.originalTitle
    }
    
    var overview: String {
        movieDetail.overview
    }
    
    var backdropPath: String? {
        AppLocalized.imagesURLPath(path: movieDetail.backdropPath ?? "")
    }
    
    var backdropData: Data? {
        dataImageUseCase.getDataFromCache(url: movieDetail.backdropPath)
    }
    
    func getBackdropData() async -> Data? {
        let url = URL(string: backdropPath ?? "")
        return await dataImageUseCase.getData(url: url)
    }
    
}
