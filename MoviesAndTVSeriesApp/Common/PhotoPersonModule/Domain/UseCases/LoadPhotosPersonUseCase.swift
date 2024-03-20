//
//  LoadPhotosPersonUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

protocol LoadPhotosPersonUseCaseType {
    func execute() async -> Result<[PhotosPerson], Error>
}

struct LoadPhotosPersonUseCase: LoadPhotosPersonUseCaseType {
    private(set) var photosRepository: PhotosPersonRepositoryType
    
    func execute() async -> Result<[PhotosPerson], Error> {
        do {
            let response = try await photosRepository.fetchPhotosPerson()
            return .success(response)
        }catch {
            return .failure(error)
        }
    }
    
    
}
