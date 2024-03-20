//
//  PhotosPersonRepositoryType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

protocol PhotosPersonRepositoryType {
    func fetchPhotosPerson() async throws -> [PhotosPerson]
}
