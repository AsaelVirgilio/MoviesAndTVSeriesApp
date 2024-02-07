//
//  PhotosPersonViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

import Combine

protocol PhotosPersonViewModelType: BaseViewModelType {
    var itemPhotosCount: Int { get }
    func getItemPhotosPersonViewModel(row: Int) -> ItemPhotosPersonViewModel
    func getPhotosURLs() -> [String]
}

final class PhotosPersonViewModel: PhotosPersonViewModelType {
    
    var state: PassthroughSubject<StateController, Never>
    var itemPhotosCount: Int {
        photos.count
    }
    
    private let loadPhotosPersonUseCase: LoadPhotosPersonUseCaseType
    private var imageDataUseCase: ImageDataUseCaseType
    private var photos: [Profile] = []
    
    init(state: PassthroughSubject<StateController, Never>,
         loadPhotosPersonUseCase: LoadPhotosPersonUseCaseType,
         imageDataUseCase: ImageDataUseCaseType
    ) {
        self.state = state
        self.loadPhotosPersonUseCase = loadPhotosPersonUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadPhotosPersonUseCase()
        }
    }
    
    private func loadPhotosPersonUseCase() async {
        
        let result = await loadPhotosPersonUseCase.execute()
        updateStateUI(result: result)
    }
    
    private func updateStateUI(result: Result<[Profile], Error>) {
        
        switch result {
            
        case .success(let photos):
            self.photos.append(contentsOf: photos)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
        
    }
    
    func getPhotosURLs() -> [String] {
        let array = photos.compactMap { $0.filePath }
        return array
    }
    
    func getItemPhotosPersonViewModel(row: Int) -> ItemPhotosPersonViewModel {
        makeItemPhotosPerson(row: row)
    }
    
    private func makeItemPhotosPerson(row: Int) -> ItemPhotosPersonViewModel {
        let photo = photos[row]
        return ItemPhotosPersonViewModel(photo: photo,
                                         imageDataUseCase: imageDataUseCase)
    }
}
