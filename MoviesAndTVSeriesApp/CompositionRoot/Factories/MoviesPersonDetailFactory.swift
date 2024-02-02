//
//  MoviesPersonDetailFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import UIKit
import Combine

protocol MoviesPersonDetailFactoryType {
    func makeMoviesPersonDetailModule(coordinator: PersonDetailViewControllerCoordinator) -> UIViewController
    
    func makeSelectedPhotoModule(photoPath: [String], delegate: SelectedPhotoCoordinatorDelegate) -> CoordinatorType
}

struct MoviesPersonDetailFactory: MoviesPersonDetailFactoryType {
    
    let itemCastViewModel: ItemCastViewModel
    
    func makeMoviesPersonDetailModule(coordinator: PersonDetailViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClientService = APIClientService()
        let urlPerson = PathLocalized.createURL(path: .personInfo, id: itemCastViewModel.id)
        
        let personDetailRepository = PersonDetailRepository(
            apiService: apiClientService,
            urlPerson: urlPerson
        )
        let loadPersonDetailUseCase = LoadPersonDetailUseCase(
            personDetailRepository: personDetailRepository
        )
        let personDetailViewModel = PersonDetailViewModel(
            loadPersonDetailUseCase: loadPersonDetailUseCase,
            state: state
        )
        
        
        //MARK: - PhotosPersonViewController
        
        let localDataImageService = LocalDataImageService()
        let url = PathLocalized.createURL(path: .personImages, id: itemCastViewModel.id)
        
        let photosPersonRepository = PhotosPersonRepository(apiService: apiClientService, urlString: url)
        let loadPhotosPersonUseCase = LoadPhotosPersonUseCase(photosRepository: photosPersonRepository)
        let imageDataRepository = ImageDataRepository(
            remoteDataService: apiClientService,
            localDataCache: localDataImageService)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let photosPersonViewModel = PhotosPersonViewModel(
            state: state,
            loadPhotosPersonUseCase: loadPhotosPersonUseCase,
            imageDataUseCase: imageDataUseCase)
        let photosPersonViewController = PhotosPersonViewController(
            collectionViewLayout: makeSectionLayout(),
            viewModel: photosPersonViewModel,
            coordinator: coordinator)
        
        let controller = PersonDetailViewController(
            photosViewController: photosPersonViewController,
            viewModel: personDetailViewModel,
            coordinator: coordinator)
        controller.title = itemCastViewModel.originalName
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
            section.supplementariesFollowContentInsets = false
            return section
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    func makeSelectedPhotoModule(photoPath: [String], delegate: SelectedPhotoCoordinatorDelegate) -> CoordinatorType {
        
        let factory = SelectedPhotoFactory(urlPhotos: photoPath)
        let navigationController = UINavigationController()
        let navigation = Navigation(rootViewController: navigationController)
        
        return SelectedPhotoCoordinator(navigationController: navigation, selectedPhotoFactory: factory, delegate: delegate)
    }
}

