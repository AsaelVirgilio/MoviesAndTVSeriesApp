//
//  SeriesGenresViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import SwiftUI

struct SeriesGenresViewController: ViewControllable {
    var holder: NavStackHolder
    
    @ObservedObject private var viewModel: SeriesGenresViewModel
    private let createSeriesListView: CreateSeriesListView
    
    @State private var isShowingDetailView = false
    @State private var genreName = ""
    
    let itemPerRow: CGFloat = 2
    let horizontalSpacing: CGFloat = 16
    let height: CGFloat = 300
    
    init(createSeriesListView: CreateSeriesListView,
         holder: NavStackHolder,
         viewModel: SeriesGenresViewModel
    ) {
        self.holder = holder
        self.viewModel = viewModel
        self.createSeriesListView = createSeriesListView
        viewModel.onAppear()
    }
    
    var body: some View {
        
            GeometryReader { geometry in
                NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<(viewModel.numberOfGenres ?? 0)) { i in
                            if i % Int(itemPerRow) == 0 {
                                NavigationLink {
                                    createSeriesListView.create(idGenre: viewModel.genres[i].idGenre)
                                } label: {
                                    buildView(rowIndex: i, geometry: geometry)
                                }
                                
                            }
                        }
                    }
                    .onAppear {
                        viewModel.onAppear()
                    }.refreshable {
                        viewModel.onAppear()
                    }
                }
            }
            .navigationTitle(AppLocalized.seriesTapTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
        var rowCards = [ItemSeriesGenresViewModel]()
        for itemIndex in 0..<Int(itemPerRow) {
            if rowIndex + itemIndex < viewModel.numberOfGenres ?? 0 {
                rowCards.append(viewModel.genres[rowIndex + itemIndex])
            }
        }
        if !rowCards.isEmpty {
            return RowView(cards: rowCards, width: 100, height: height, horizontalSpacing: horizontalSpacing)
        }
        
        return nil
    }
    
    func getWidth(geometry: GeometryProxy) -> CGFloat {
        let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
        return width
    }
    
}

struct RowView: View {
    let cards: [ItemSeriesGenresViewModel]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards, id: \.idGenre) { genre in
                SeriesGenresCell(title: genre.name)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }
}
