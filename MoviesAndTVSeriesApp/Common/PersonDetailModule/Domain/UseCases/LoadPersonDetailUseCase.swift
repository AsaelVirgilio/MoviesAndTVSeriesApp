//
//  LoadPersonDetailUseCase.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

protocol LoadPersonDetailUseCaseType {
    func execute() async throws -> PersonDetail
}

struct LoadPersonDetailUseCase: LoadPersonDetailUseCaseType {
    private(set) var personDetailRepository: PersonDetailRepositoryType
    
    func execute() async throws -> PersonDetail {
        let response = try await personDetailRepository.fetchPersonDetail()
        return response
    }
    
}
