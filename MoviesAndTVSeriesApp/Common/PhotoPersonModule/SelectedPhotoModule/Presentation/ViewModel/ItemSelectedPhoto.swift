//
//  ItemSelectedPhoto.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Foundation

struct ItemSelectedPhoto {
    private(set) var photoPath: String
    private(set) var imageDataUseCase: ImageDataUseCaseType
    
    var completePhotoPath: String {
        AppLocalized.imagesURLPath(path: photoPath)
    }
    
    var imageData: Data? {
        return imageDataUseCase.getDataFromCache(url: completePhotoPath)
    }
    
    func getImageData() async -> Data? {
        let url = URL(string: completePhotoPath)
        return await imageDataUseCase.getData(url: url)
    }
    
}
