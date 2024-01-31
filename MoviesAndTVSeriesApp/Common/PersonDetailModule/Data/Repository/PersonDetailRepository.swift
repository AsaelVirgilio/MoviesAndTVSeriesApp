//
//  PersonDetailRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import Foundation

struct PersonDetailRepository: PersonDetailRepositoryType {
    private(set) var apiService: APIClientService
    private(set) var urlPerson: String
    
    func fetchPersonDetail() async throws -> PersonDetail {
        
        let url = URL(string: urlPerson)
        let person = try await apiService.request(url: url, type: PersonDetailDTO.self)
        return person.toDomain()
        
    }
    
    
}
