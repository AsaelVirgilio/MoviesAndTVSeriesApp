//
//  SearchMediaViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 05/02/24.
//

import Foundation
import Combine

protocol SearchMediaViewModelType: BaseViewModelType {
    var numberOfItems: Int { get }
    var lastPage: Bool { get }
    func getItemSearchMediaViewModel(row: Int) -> ItemSearchMediaViewModel
    func getMediaViewModel(row: Int) -> SearchResults
}

final class SearchMediaViewModel: SearchMediaViewModelType {
    var numberOfItems: Int {
        searchs.count
    }
    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    
    private var searchs: [SearchResults] = []
    private var loadSearchUseCase: LoadSearchMediaUseCaseType
    private var lastPageValidationUseCase: LastPageValidationUseCaseType
    private var imageDataUseCase: ImageDataUseCaseType
    var state: PassthroughSubject<StateController, Never>
    
    init(state: PassthroughSubject<StateController, Never>,
         loadSearchUseCase: LoadSearchMediaUseCaseType,
         lastPageValidationUseCase: LastPageValidationUseCaseType,
         imageDataUseCase: ImageDataUseCaseType
    ) {
        self.state = state
        self.loadSearchUseCase = loadSearchUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            await loadSearchsUseCase()
        }
    }
    
    private func loadSearchsUseCase() async {
        
        let result = await loadSearchUseCase.execute()
        updateStateUI(response: result)
        
    }
    
    private func updateStateUI(response: Result<[SearchResults], Error>) {
        
        switch response {
            
        case .success(let movies):
            lastPageValidationUseCase.updateLastPage(itemsCount: searchs.count)
            self.searchs.append(contentsOf: movies)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemSearchMediaViewModel(row: Int) -> ItemSearchMediaViewModel {
        checkAndLoadMoreSearches(row: row)
        return makeItemSearchMediaViewModel(row: row)
    }
    
    func getMediaViewModel(row: Int) -> SearchResults {
        searchs[row]
    }
    
    private func makeItemSearchMediaViewModel(row: Int) -> ItemSearchMediaViewModel {
        let search = searchs[row]
        return ItemSearchMediaViewModel(media: search, dataImageUseCase: imageDataUseCase)
    }
    
    private func checkAndLoadMoreSearches(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(row: row, actualItems: searchs.count, action: viewDidLoad)
    }
    
}

