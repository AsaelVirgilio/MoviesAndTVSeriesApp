//
//  SearchMovieFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import UIKit
import Combine

protocol SearchMovieFactoryType {
    func makeSearchMovieFactory(coordinator: SearchMediaViewControllerCoordinator) -> UIViewController
    var dicInfo: [String:Any] {get set}
    
    func makeMovieDetailCoordinator(navigation: NavigationType,
                                    movie: SearchResults,
                                    parentCoordinator: ParentCoordinator) -> CoordinatorType
    
}

struct SearchMovieFactory: SearchMovieFactoryType {
    
    var dicInfo: [String:Any]
    
    func makeSearchMovieFactory(coordinator: SearchMediaViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let lastPageValidationUseCase = LastPageValidationUseCase()
        let apiService = APIClientService()
        let keyword = dicInfo["key"] as? String ?? ""
        let idGenre = dicInfo["idGenre"] as? Int ?? 0
        
        let localDataImageService = LocalDataImageService()
        let searchMediaRepository = SearchMediaRepository(apiService: apiService, idGenre: idGenre, keyword: keyword)
        let imageDataRepository = ImageDataRepository(remoteDataService: apiService, localDataCache: localDataImageService)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let loadSearchMediaUseCase = LoadSearchMediaUseCase(searchMediaRepository: searchMediaRepository, pageNum: 0)
        let searchMediaViewModel = SearchMediaViewModel(state: state, loadSearchUseCase: loadSearchMediaUseCase, lastPageValidationUseCase: lastPageValidationUseCase, imageDataUseCase: imageDataUseCase)
        let controller = SearchMediaViewController(viewModel: searchMediaViewModel, coordinator: coordinator)
        return controller
    }
    
    func makeMovieDetailCoordinator(
        navigation: NavigationType,
        movie: SearchResults,
        parentCoordinator: ParentCoordinator
    ) -> CoordinatorType {
        let movie = Movie(adult: movie.adult,
                          backdropPath: movie.backdropPath,
                          id: movie.id,
                          title: movie.title,
                          originalTitle: movie.originalTitle,
                          overview: movie.overview,
                          posterPath: movie.posterPath,
                          genreIDS: movie.genreIDS ?? [0],
                          releaseDate: movie.releaseDate ?? "",
                          voteAverage: movie.voteAverage ?? 0.0
        )
        let factory = MovieDetailFactory(movie: movie)
        
        return MovieDetailCoordinator(navigationController: navigation,
                                      factoryDetail: factory,
                                      parentCoordinator: parentCoordinator)

    }
    
    
}
