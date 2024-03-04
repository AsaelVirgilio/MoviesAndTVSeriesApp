//
//  ItemSeriesListView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import SwiftUI
import UIKit

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
        HStack {
            Image(uiImage: setImage())
                .resizable()
                .scaledToFit()
                .mask(RoundedRectangle(cornerRadius: 13))
            .clipped()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack {
                Text(serie.name)
                    .font(.title2)
                    .lineLimit(0)
                
                HStack {
                    Text(DateFormater.formatDate(date: serie.firstAirDate))
                        .font(.title3)
                        .frame(width: 100)
                        
                    Text(iconVote.rawValue)
                        .font(.headline)
//                        .fontWidth(.compressed)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
//                .padding()
            }
//            .padding()
        }
    }
    
    @MainActor private func setImage() -> UIImage {
        var image: UIImage = UIImage()
        
        if let data = imageData {
            image = setImageFromData(data: data)
        }
        else{
            var dataImage: Data?
            Task {
                dataImage = await getImageData()
            }
            image = setImageFromData(data: dataImage)
        }
        return image
    }
    
    func setImageFromData( data: Data?) -> UIImage {
        if let data = data {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return UIImage(named: "default") ?? UIImage()
    }
    
    func addDefaultImage() -> UIImage {
        return UIImage(named: "default") ?? UIImage()
        
    }
}

