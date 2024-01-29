//
//  MovieDetailFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import UIKit
import Combine

protocol MovieDetailFactoryType {
    func makeMovieDetailModule(coordinator: MovieDetailViewControllerCoordinator) -> UIViewController
}

struct MovieDetailFactory: MovieDetailFactoryType {
    
    let movie: Movie
    
    func makeMovieDetailModule(coordinator: MovieDetailViewControllerCoordinator) -> UIViewController {
        
        let state = PassthroughSubject<StateController, Never>()
        let apiService = APIClientService()
        let localDataImageService = LocalDataImageService()
        let movieDetailRepository = MovieDetailRepository()
        let urlVideos = PathLocalized.createURL(path: .moviesTrailers, id: movie.id)
        
        let imageDataRepository = ImageDataRepository(remoteDataService: apiService, localDataCache: localDataImageService)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let loadMovieDetailUseCase = LoadMovieDetailUseCase(movieDetailRepository: movieDetailRepository, movie: movie)
        let movieDetailViewModel = MovieDetailViewModel(
            state: state,
            loadMovieDetailUseCase: loadMovieDetailUseCase,
            imageDataUseCase: imageDataUseCase
        )
        
        let videoTrailerRepository = VideoTrailerRepository(
            remoteService: apiService,
            url: urlVideos)
        let loadVideoTrailerUseCase = LoadVideoTrailerUseCase(
            videoTrailerRepository: videoTrailerRepository)
        let videoTrailerViewModel = VideoTrailerViewModel(
            state: state,
            loadVideoUseCase: loadVideoTrailerUseCase)
        let videoTrailerViewController = VideoTrailerViewController(
            coordinator: coordinator,
            viewModel: videoTrailerViewModel)
        let controller = MovieDetailViewController(
            videoTrailerViewController: videoTrailerViewController,
            viewModel: movieDetailViewModel,
            coordinator: coordinator
        )
        return controller
    }
    
    
}
