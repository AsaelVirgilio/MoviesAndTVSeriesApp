//
//  ItemCastViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

struct ItemCastViewModel {
    
    private(set) var person: Person
    private(set) var dataImageUseCase: ImageDataUseCaseType
    
    var id: Int {
        person.id
    }
    
    var originalName: String {
        person.name
    }
    
    var knownForDepartment: String {
        person.knownForDepartment
    }
    
    var profilePath: String {
        AppLocalized.imagesURLPath(path: person.profilePath ?? "")
    }
    
    var character: String {
        person.character ?? ""
    }
    
    
    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: profilePath)
    }
    
    func getImageData() async -> Data? {
        let url = URL(string: profilePath)
        return await dataImageUseCase.getData(url: url)
    }
    
}
