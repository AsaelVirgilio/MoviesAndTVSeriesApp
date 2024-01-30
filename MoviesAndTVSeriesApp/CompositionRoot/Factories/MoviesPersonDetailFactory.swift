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
        let controller = PersonDetailViewController(
            viewModel: personDetailViewModel,
            coordinator: coordinator)
        controller.title = itemCastViewModel.originalName
        return controller
        
    }
}
