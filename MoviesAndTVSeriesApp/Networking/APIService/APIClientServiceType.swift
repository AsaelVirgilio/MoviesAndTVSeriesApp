//
//  APIClientServiceType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Foundation

protocol APIClientServiceType {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}
