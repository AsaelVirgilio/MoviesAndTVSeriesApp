//
//  ItemSearchMediaViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 05/02/24.
//
import Foundation

struct ItemSearchMediaViewModel {
    var media: SearchResults
    private(set) var dataImageUseCase: ImageDataUseCaseType
    
    var title: String {
        media.title
    }
    
    var releaseDate: String {
        media.releaseDate
    }
    
    var voteAverage: Double {
        media.voteAverage
    }
    
    var posterPath: String {
        AppLocalized.imagesURLPath(path: media.posterPath ?? "")
    }
    
    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: posterPath)
    }
    
    func getImageData() async -> Data? {
        let url = URL(string: posterPath)
        return await dataImageUseCase.getData(url: url)
    }
    
    var iconVote: VoteIcon {
        
        switch voteAverage {
        case 0..<3:
            return .tooBad
        case 3..<5:
            return .bad
        case 5..<6.5:
            return .regular
        case 6.5..<8:
            return .good
        case 8...10:
            return .great
        default:
            return ._default
        }
    }
}

//enum VoteIcon: String {
//    case tooBad = "⭐️"
//    case bad = "⭐️⭐️"
//    case regular = "⭐️⭐️⭐️"
//    case good = "⭐️⭐️⭐️⭐️"
//    case great = "⭐️⭐️⭐️⭐️⭐️"
//    case _default = "🚫"
//}


