//
//  ImageDataRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

protocol ImageDataRepositoryType {
    func fetchData(url: URL?) async -> Data?
    func getFromCache(url: String?) -> Data?
}
