//
//  SelectedPhotoFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import UIKit
import Combine

protocol SelectedPhotoFactoryType {
    func makeSelectedPhotoModule(coordinator: SelectedPhotosPersonViewControllerCoordinator) -> UIViewController
}

struct SelectedPhotoFactory: SelectedPhotoFactoryType {
    
    var urlPhotos: [String]
    var idPhoto: IndexPath
    
    func makeSelectedPhotoModule(coordinator: SelectedPhotosPersonViewControllerCoordinator) -> UIViewController {
    
        let state = PassthroughSubject<StateController, Never>()
        
        let localDataImageService = LocalDataImageService()
        let apiService = APIClientService()
        let imageDataRepository = ImageDataRepository(remoteDataService: apiService, localDataCache: localDataImageService)
        let imageDataUseCase = ImageDataUseCase(imageDataRepository: imageDataRepository)
        let selectedPhotoPersonViewModel = SelectedPhotoPersonViewModel(
            state: state,
            photosPath: urlPhotos,
            imageDataUseCase: imageDataUseCase
        )
        let controller = SelectedPhotoPersonViewController(
            layout: makeSectionLayout(), coordinator: coordinator,
            viewModel: selectedPhotoPersonViewModel, idPhoto: idPhoto
        )
        return controller
    }
    
    private func makeSectionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            //item
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.75)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            //group
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
            //section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
//            section.boundarySupplementaryItems = [supplementaryHeaderItem()]
            section.supplementariesFollowContentInsets = false
            return section
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
