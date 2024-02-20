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
    let itemPerRow: CGFloat = 1
    let horizontalSpacing: CGFloat = 16
    let height: CGFloat = 300
//    let cards: [Card] = MockStore.cards
    
    init(holder: NavStackHolder,
         viewModel: SeriesGenresViewModel
    ) {
        self.holder = holder
        self.viewModel = viewModel
        viewModel.onAppear()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(0..<(viewModel.numberOfGenres ?? 0)) { i in
                        if i % Int(itemPerRow) == 0 {
                            buildView(rowIndex: i, geometry: geometry)
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
    }
    
    func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
        var rowCards = [ItemSeriesGenresViewModel]()
        for itemIndex in 0..<Int(itemPerRow) {
            if rowIndex + itemIndex < viewModel.numberOfGenres ?? 0 {
                rowCards.append(viewModel.genres[rowIndex + itemIndex])
            }
        }
        if !rowCards.isEmpty {
            return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: height, horizontalSpacing: horizontalSpacing)
        }
        
        return nil
    }
    
    func getWidth(geometry: GeometryProxy) -> CGFloat {
        let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
        return width
    }
    
}

//#Preview {
////    SeriesGenresViewController()
//}
//struct Card: Identifiable {
//    let id = UUID()
//    let title: String
//}

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
