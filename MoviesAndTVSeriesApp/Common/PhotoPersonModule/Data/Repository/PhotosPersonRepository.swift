//
//  PhotosPersonRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//
import Foundation

struct PhotosPersonRepository: PhotosPersonRepositoryType {
    private(set) var apiService: APIClientServiceType
    private(set) var urlString: String
    
    func fetchPhotosPerson() async throws -> [Profile] {
        
        let url = URL(string: urlString)
        let response = try await apiService.request(url: url, type: PhotosPersonDTO.self)
        
        return response.toDomain()
    }
}
