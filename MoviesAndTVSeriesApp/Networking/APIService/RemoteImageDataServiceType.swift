//
//  RemoteImageDataServiceType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

protocol RemoteImageDataServiceType {
    func request(url: URL?) async -> Data?
}
