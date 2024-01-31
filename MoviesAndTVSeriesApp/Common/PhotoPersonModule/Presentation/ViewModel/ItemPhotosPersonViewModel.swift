//
//  ItemPhotosPersonViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//
import Foundation

struct ItemPhotosPersonViewModel {
    private(set) var photo: Profile
    private(set) var imageDataUseCase: ImageDataUseCaseType
    
    var filePath: String {
        AppLocalized.imagesURLPath(path: photo.filePath)
    }
    
    var imageData: Data? {
        return imageDataUseCase.getDataFromCache(url: filePath)
    }
    
    func getImageData() async -> Data? {
        let url = URL(string: filePath)
        return await imageDataUseCase.getData(url: url)
    }
    
}
