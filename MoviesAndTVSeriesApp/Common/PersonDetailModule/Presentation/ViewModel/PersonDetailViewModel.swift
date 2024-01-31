//
//  PersonDetailViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Combine

protocol PersonDetailViewModelType: BaseViewModelType {
    var personDetail: ItemPersonDetailViewModel? { get }
}

final class PersonDetailViewModel: PersonDetailViewModelType {
    private let loadPersonDetailUseCase: LoadPersonDetailUseCaseType
    var personDetail: ItemPersonDetailViewModel?
    var state: PassthroughSubject<StateController, Never>
    
    init(loadPersonDetailUseCase: LoadPersonDetailUseCaseType,
         state: PassthroughSubject<StateController, Never>
    ) {
        self.loadPersonDetailUseCase = loadPersonDetailUseCase
        self.state = state
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
           await loadPersonDetailUseCase()
        }
    }
    
    private func loadPersonDetailUseCase() async {
        do {
            let response = try await loadPersonDetailUseCase.execute()
            self.personDetail = ItemPersonDetailViewModel(personDetail: response)
            state.send(.success)
        } catch {
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
}
