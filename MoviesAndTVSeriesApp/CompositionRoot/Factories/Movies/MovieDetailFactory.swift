//
//  MovieDetailFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import UIKit
import Combine
import youtube_ios_player_helper_swift

protocol MovieDetailFactoryType {
    func makeMovieDetailModule(coordinator: MovieDetailViewControllerCoordinator) -> UIViewController
    
    func makeMoviesPersonDetailCoordinator(navigation: NavigationType, itemCastViewModel: ItemCastViewModel, coordinator: ParentCoordinator) -> CoordinatorType
}

struct MovieDetailFactory: MovieDetailFactoryType {
    
    let movie: Movie
    
    func makeMovieDetailModule(coordinator: MovieDetailViewControllerCoordinator) -> UIViewController {
        
        let state = PassthroughSubject<StateController, Never>()
        let apiServiceCast = APIClientService()
        let apiServiceVideo = APIClientService()
        let apiServiceRepository = APIClientService()
        let localDataImageService = LocalDataImageService()
        let movieDetailRepository = MovieDetailRepository()
        let urlVideos = PathLocalized.createURL(path: .moviesTrailers, id: movie.id)
        let urlCast = PathLocalized.createURL(path: .movieCredits, id: movie.id)
        
        let imageDataRepository = ImageDataRepository(remoteDataService: apiServiceRepository, localDataCache: localDataImageService)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let loadMovieDetailUseCase = LoadMovieDetailUseCase(movieDetailRepository: movieDetailRepository, movie: movie)
        let movieDetailViewModel = MovieDetailViewModel(
            state: state,
            loadMovieDetailUseCase: loadMovieDetailUseCase,
            imageDataUseCase: imageDataUseCase
        )
        
        //MARK: - VideoTrailerViewController
        let videoTrailerRepository = VideoTrailerRepository(
            remoteService: apiServiceVideo,
            url: urlVideos)
        let loadVideoTrailerUseCase = LoadVideoTrailerUseCase(
            videoTrailerRepository: videoTrailerRepository)
        let videoTrailerViewModel = VideoTrailerViewModel(
            state: state,
            loadVideoUseCase: loadVideoTrailerUseCase)
        let videoPlayer = VideoPlayerYTPlayerView()
        let videoTrailerViewController = VideoTrailerViewController(
            videoPlayer: videoPlayer, coordinator: coordinator,
            viewModel: videoTrailerViewModel)
        
        //MARK: - CastViewController
        
        let castRepository = CastRepository(remoteService: apiServiceCast, urlString: urlCast)
        let loadCastUseCase = LoadCastUseCase(castRepository: castRepository)
        let castViewModel = CastViewModel(state: state, loadCastUseCase: loadCastUseCase, imageDataUseCase: imageDataUseCase)
        let castViewController = CastViewController(collectionViewLayout: makeSectionLayout(), viewModel: castViewModel, coordinator: coordinator)
        
        //MARK: - MovieDetailViewController
        let controller = MovieDetailViewController(
            videoTrailerViewController: videoTrailerViewController,
            viewModel: movieDetailViewModel,
            coordinator: coordinator,
            castViewController: castViewController
        )
        return controller
    }
    
    private func makeSectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            //item
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(2)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            //group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(1)), subitems: [item])
            //section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 0, leading: 10, bottom: 30, trailing: 10)
            section.boundarySupplementaryItems = [supplementaryHeaderItem()]
//            section.supplementariesFollowContentInsets = false
            return section
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    func makeMoviesPersonDetailCoordinator(navigation: NavigationType, itemCastViewModel: ItemCastViewModel, coordinator: ParentCoordinator) -> CoordinatorType {
        let factory = MoviesPersonDetailFactory(itemCastViewModel: itemCastViewModel)
        
        return MoviesPersonDetailCoordinator(navigationController: navigation,
                                             detailPersonFactory: factory,
                                             parentCoordinator: coordinator)
    }
    
    
}
