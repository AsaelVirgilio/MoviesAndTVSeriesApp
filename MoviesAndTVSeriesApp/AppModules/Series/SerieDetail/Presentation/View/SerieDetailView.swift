//
//  SerieDetailView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 14/03/24.
//

import SwiftUI

struct SerieDetailView: View {
    @ObservedObject var viewModel: SerieDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            }else{
                if viewModel.showErrorMessage == nil {
                    
                    AsyncImage(url: URL(string: viewModel.serieDetail?.getImage() ?? "default"), content: { $0.resizable()}, placeholder: {
                            Image(uiImage: UIImage(named: "default") ?? UIImage())
                            
                        })
                        .scaledToFit()
                        .clipped()
                        .mask(RoundedRectangle(cornerRadius: 13))
                        .frame(width: 300, height: 200)
                    
                    Text(viewModel.serieDetail?.originalName ?? "")
                        .font(.system(size: 10))
                        .lineLimit(0)
                        
                    Text(viewModel.serieDetail?.overview ?? "")
                        .font(.system(size: 10))
                        .lineLimit(0)
                }
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
        .refreshable {
//            viewModel.onAppear()
        }
    }
}

//#Preview {
//    SerieDetailView()
//}
