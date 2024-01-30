//
//  CastRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation
protocol CastRepositoryType {
    func fetchCast() async throws -> [Person]
}
