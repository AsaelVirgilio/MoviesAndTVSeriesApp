//
//  ItemSeriesListView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import SwiftUI

struct ItemSeriesListView: View {
    let serie: Serie
    var dataImageUseCase: ImageDataUseCaseType
    
    var posterPath: String {
        AppLocalized.imagesURLPath(path: serie.posterPath)
    }
    
    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: posterPath)
    }
    var voteAverage: Double {
        serie.voteAverage
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
    
    var body: some View {
        VStack {
//            HStack {
//            Image(UIImage(data: getImageData() ?? Data()))
//                    .resizable()
//                    .scaledToFill()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: CGFloat(200), height: CGFloat(100), alignment: .center)
            
                Text(serie.originalName)
                    .font(.title3)
                    .lineLimit(1)
            
                Text(serie.name)
                    .font(.headline)
//            }
        }
    }
}
