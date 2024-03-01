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
        VStack {
            Image(title, bundle: nil)
                .resizable()
                .scaledToFill()
//                .scaledToFit()
                .mask(RoundedRectangle(cornerRadius: 13))
                .overlay (
                    OverlayForImage(name: title), 
                    alignment: Alignment(horizontal: .leading, vertical: .bottom)
                        
                )
//                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
        }
        
    }
}

struct OverlayForImage: View {
    var name: String
    
    var body: some View {
        ZStack {
            Label(name, systemImage: "" )
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.semibold)
        }
        .padding(5)
    }
}
//#Preview {
//    SeriesCard()
//}
