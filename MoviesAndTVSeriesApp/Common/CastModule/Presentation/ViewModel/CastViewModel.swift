//
//  CastViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Combine

protocol CastViewModelType: BaseViewModelType {
    var itemPersonsCount: Int { get }
    func getItemMenuViewModel(row: Int) -> ItemCastViewModel
}

final class CastViewModel: CastViewModelType {
    var state: PassthroughSubject<StateController, Never>
    var itemPersonsCount: Int {
        persons.count
    }
    
    
    private var persons: [Person] = []
    private var loadCastUsecase: LoadCastUseCaseType
    private var imageDataUseCase: ImageDataUseCaseType
    
    init(state: PassthroughSubject<StateController, Never>,
         loadCastUseCase: LoadCastUseCaseType,
         imageDataUseCase: ImageDataUseCaseType
    ) {
        self.state = state
        self.loadCastUsecase = loadCastUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            await loadPersonsUseCase()
        }
    }
    
    private func loadPersonsUseCase() async {
        let response = await loadCastUsecase.execute()
        updateStateUI(resultUseCase: response)
    }
    
    private func updateStateUI(resultUseCase: Result<[Person], Error>) {
        
        switch resultUseCase {
        case .success(let persons):
            self.persons.append(contentsOf: persons)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemMenuViewModel(row: Int) -> ItemCastViewModel {
        makeItemMenuViewModel(row: row)
    }
    
    private func makeItemMenuViewModel(row: Int) -> ItemCastViewModel {
        
        let person = persons[row]
        return ItemCastViewModel(person: person, dataImageUseCase: imageDataUseCase)
        
    }
}
