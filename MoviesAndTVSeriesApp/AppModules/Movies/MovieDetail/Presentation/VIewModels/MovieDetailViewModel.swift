//
//  MovieDetailViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import Combine
import Foundation

protocol MovieDetailViewModelType {
    var state: PassthroughSubject<StateController, Never> { get }
    
    func viewDidLoad()
    func getItemMovieDetailViewModel() -> ItemMovieDetailViewModel
    
}

final class MovieDetailViewModel: MovieDetailViewModelType {
    var state: PassthroughSubject<StateController, Never>
    private let loadMovieDetailUseCase: LoadMovieDetailUseCaseType
    private let imageDataUseCase: ImageDataUseCaseType
    private var movieDetail: MovieDetail = MovieDetail(id: 0, backdropPath: "", originalTitle: "", overview: "")
    
    init(state: PassthroughSubject<StateController, Never>,
         loadMovieDetailUseCase: LoadMovieDetailUseCaseType,
         imageDataUseCase: ImageDataUseCaseType
    ) {
        self.state = state
        self.loadMovieDetailUseCase = loadMovieDetailUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadMovieDetailUseCase()
        }
        
    }
    
    
    private func loadMovieDetailUseCase() async {
        let result = await loadMovieDetailUseCase.execute()
        uploadState(response: result)
    }
    
    private func uploadState(response: Result<MovieDetail, Error>) {
        
        switch response {
            
        case .success(let result):
            self.movieDetail = result
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
        
    }
    
    func getItemMovieDetailViewModel() -> ItemMovieDetailViewModel {
        makeItemMovieDetailViewModel()
    }
    
    private func makeItemMovieDetailViewModel() -> ItemMovieDetailViewModel {
        
        return ItemMovieDetailViewModel(
            movieDetail: movieDetail,
            dataImageUseCase: imageDataUseCase)
    }
    
}
