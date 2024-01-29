//
//  ItemVideoTrailerViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

struct ItemVideoTrailerViewModel {
    private(set) var video: Video
    
    var key: String {
        video.key
    }
    
    var videoPath: String {
        AppLocalized.videosPath(key: video.key)
    }
    
//    let name, key: String
//    let site: String
//    let size: Int
//    let type: String
//    let official: Bool
//    let publishedAt, id: String
}
