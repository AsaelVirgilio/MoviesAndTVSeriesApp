//
//  MoviesViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Combine

protocol MoviesViewModelType: BaseViewModelType {
    var itemsMoviesCount: Int { get }
    var lastPage: Bool { get }
    func getItemMoviesViewModel(row: Int) -> ItemMoviesViewModel
}

final class MoviesViewModel: MoviesViewModelType {
    
    var state: PassthroughSubject<StateController, Never>
    var itemsMoviesCount: Int {
        movies.count
    }
    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    
    private var movies: [Movie] = []
    private var loadMoviesUseCase: LoadMoviesUseCaseType
    private var lastPageValidationUseCase: LastPageValidationUseCase
    private var imageDataUseCase: ImageDataUseCaseType
    
    init(state: PassthroughSubject<StateController, Never>,
         loadMoviesUseCase: LoadMoviesUseCaseType,
         lastPageValidationUseCase: LastPageValidationUseCase,
         imageDataUseCase: ImageDataUseCaseType) {
        self.state = state
        self.loadMoviesUseCase = loadMoviesUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadMoviesUseCase()
        }
    }
    
    private func loadMoviesUseCase() async {
        let resultUseCase = await loadMoviesUseCase.execute()
        updateStateUI(resultUseCase: resultUseCase)
    }
    
    private func updateStateUI(resultUseCase: Result<[Movie], Error>) {
        
        switch resultUseCase {
        case .success(let movies):
            lastPageValidationUseCase.updateLastPage(itemsCount: movies.count)
            self.movies.append(contentsOf: movies)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    
    func getItemMoviesViewModel(row: Int) -> ItemMoviesViewModel {
        checkAndLoadMoreMovies(row: row)
        return makeItemMoviesViewModel(row: row)
    }
    
    private func makeItemMoviesViewModel(row: Int) -> ItemMoviesViewModel {
        let movie = movies[row]
        return ItemMoviesViewModel(movie: movie, dataImageUseCase: imageDataUseCase)
    }
    
    private func checkAndLoadMoreMovies(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(row: row, actualItems: movies.count, action: viewDidLoad)
    }
    
}
