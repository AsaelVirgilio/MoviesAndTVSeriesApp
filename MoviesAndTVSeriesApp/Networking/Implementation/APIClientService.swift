//
//  APIClientService.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//


import Foundation

struct APIClientService: APIClientServiceType {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(url: URL?, type: T.Type) async throws -> T where T : Decodable {
        
            guard let url = url else { throw ApiError.errorInURL}
            
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw ApiError.unknowError}
                    
            switch httpResponse.statusCode {
            case HttpResponseStatus.ok:
                return try decodeModel(data: data)
            case HttpResponseStatus.clientError:
                throw ApiError.clientError
            case HttpResponseStatus.serverError:
                throw ApiError.serverError
            default:
                throw ApiError.unknowError
            }
    }
    
    private func decodeModel<T:Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
    
}
