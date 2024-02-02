//
//  SelectedPhotoPersonViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Combine
import UIKit

protocol SelectedPhotoPersonViewModelType: BaseViewModelType {
    func getItemSelectedPhoto(index: Int) -> ItemSelectedPhoto
    var numberOfPhotos: Int { get }
}

final class SelectedPhotoPersonViewModel: SelectedPhotoPersonViewModelType {
    var state: PassthroughSubject<StateController, Never>
    private var photosPath: [String]
    private var imageDataUseCase: ImageDataUseCaseType
    var numberOfPhotos: Int {
        photosPath.count
    }
    
    init(state: PassthroughSubject<StateController, Never>,
         photosPath: [String],
         imageDataUseCase: ImageDataUseCaseType
    ) {
        self.state = state
        self.photosPath = photosPath
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
//        print("------> URLs \(photosPath)")
    }
    
    func getItemSelectedPhoto(index: Int) -> ItemSelectedPhoto {
        makeItemSelectedPhoto(index: index)
    }
    
    private func makeItemSelectedPhoto(index: Int) -> ItemSelectedPhoto {
        ItemSelectedPhoto(photoPath: photosPath[index], imageDataUseCase: imageDataUseCase)
    }
}
