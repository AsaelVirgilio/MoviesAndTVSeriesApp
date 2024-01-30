//
//  PersonDetailRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

protocol PersonDetailRepositoryType {
    func fetchPersonDetail() async throws -> PersonDetail
}
