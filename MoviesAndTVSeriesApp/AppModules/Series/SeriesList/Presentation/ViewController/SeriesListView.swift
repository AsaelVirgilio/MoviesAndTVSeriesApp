//
//  SeriesListView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import SwiftUI

struct SeriesListView: View {
    @ObservedObject var viewModel: SeriesListViewModel
    var imageDataUseCase: ImageDataUseCaseType
    
    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                if viewModel.showLoadingSpinner {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    if viewModel.showErrorMessage == nil {
                        NavigationStack {
                            List {
                                ForEach (viewModel.series, id:  \.id) { serie in
                                    NavigationLink {
                                        Text("----> serie \(serie.originalName)")
                                    } label: {
                                        SeriesListItemView(serie: serie, dataImageUseCase: imageDataUseCase)
                                    }
                                }
                            }
                        }
                    } else {
                        Text(viewModel.showErrorMessage!)
                    }
                }
                
            }
        }
        .onAppear(){
            viewModel.onAppear()
        }
        .refreshable {
            viewModel.onAppear()
        }
    }
}

