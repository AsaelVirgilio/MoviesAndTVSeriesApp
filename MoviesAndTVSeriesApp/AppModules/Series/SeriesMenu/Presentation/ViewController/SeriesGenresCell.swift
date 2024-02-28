//
//  SeriesGenresCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import SwiftUI

struct SeriesGenresCell: View {
    let title: String
    
    var body: some View {
        VStack {
            Image(title, bundle: nil)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat(100), height: CGFloat(100), alignment: .center)
            
            Text(title)
                .font(.title2)
        }
        
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
