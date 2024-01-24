//
//  MoviesGenresViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import UIKit
import Combine

protocol MoviesGenresViewModelType: BaseViewModelType {
    var itemsMovieGenresCount: Int { get }
    func getItemMovieGenreViewModel(row: Int) -> ItemMoviesGenresViewModel
//    func getGenreMovie(row: Int) -> MGenre
}

final class MoviesGenresViewModel: MoviesGenresViewModelType {
    var itemsMovieGenresCount: Int {
        genres.count
    }
    
    private var genres: [MGenre] = []
    private let loadMoviesGenreUseCase: LoadMoviesGenresUseCaseType
    var state: PassthroughSubject<StateController, Never>
    
    init(loadMoviesGenreUseCase: LoadMoviesGenresUseCaseType,
         state: PassthroughSubject<StateController, Never>
    ) {
        self.loadMoviesGenreUseCase = loadMoviesGenreUseCase
        self.state = state
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            await loadGenresUseCase()
        }
    }
    
    private func loadGenresUseCase() async {
        let resultGenres = await loadMoviesGenreUseCase.execute()
        updateStateUI(resultUseCase: resultGenres)
    }
    
    private func updateStateUI(resultUseCase: Result<[MGenre], Error>) {
        
        switch resultUseCase {
            
        case .success(let genres):
            self.genres.append(contentsOf: genres)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemMovieGenreViewModel(row: Int) -> ItemMoviesGenresViewModel {
        makeItemGenreViewModel(row: row)
    }
    private func makeItemGenreViewModel(row: Int) -> ItemMoviesGenresViewModel {
        let genre = genres[row]
        return ItemMoviesGenresViewModel(genre: genre)
    }
    
//    func getGenreMovie(row: Int) -> MGenre {
//        self.genres[row]
//    }
    
}
