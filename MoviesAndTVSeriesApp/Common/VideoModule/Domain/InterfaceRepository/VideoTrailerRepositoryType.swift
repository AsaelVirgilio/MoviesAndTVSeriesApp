//
//  VideoTrailerRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Foundation

protocol VideoTrailerRepositoryType {
    func fetchVideoTrailer() async throws -> [Video]
}
