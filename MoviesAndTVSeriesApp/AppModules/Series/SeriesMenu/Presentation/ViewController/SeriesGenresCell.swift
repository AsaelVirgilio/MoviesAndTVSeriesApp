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
//            RoundedRectangle(cornerRadius: 12).foregroundColor(.random)
            Image(title, bundle: nil)
//                .scaledToFit()
                .scaledToFill()
//                .frame(width: CGFloat(100), height: CGFloat(200), alignment: .center)
            Text(title)
                .font(.title2)
        }
        
    }
}

#Preview {
    SeriesGenresCell(title: "Hello world")
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
