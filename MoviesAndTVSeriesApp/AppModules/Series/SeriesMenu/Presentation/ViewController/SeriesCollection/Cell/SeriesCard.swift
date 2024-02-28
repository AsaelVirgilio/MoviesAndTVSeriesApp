//
//  SeriesCard.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/02/24.
//

import SwiftUI


struct SeriesCard: View {
    let title: String
    
    var body: some View {
        ZStack {
            Image(title, bundle: nil)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat(150), height: CGFloat(150), alignment: .center)
            
            Text(title)
                .font(.title2)
        }
        
    }
}

//#Preview {
//    SeriesCard()
//}
