//
//  SeriesListView.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 21/02/24.
//

import SwiftUI

struct SeriesListView: ViewControllable {
    
    @ObservedObject var viewModel: SeriesListViewModel
    var holder: NavStackHolder
    var dataImageUseCase: ImageDataUseCaseType
    
    init(dataImageUseCase: ImageDataUseCaseType,
        viewModel: SeriesListViewModel,
         holder: NavStackHolder
    ) {
        self.dataImageUseCase = dataImageUseCase
        self.viewModel = viewModel
        self.holder = holder
    }
    
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
                                        ItemSeriesListView(serie: serie, dataImageUseCase: dataImageUseCase)
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

