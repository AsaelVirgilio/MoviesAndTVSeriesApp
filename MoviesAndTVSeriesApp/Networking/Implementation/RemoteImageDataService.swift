//
//  RemoteImageDataService.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//


import Foundation

extension APIClientService: RemoteImageDataServiceType {
    func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return (data: data, request: request).data
        } catch {
            return nil
        }
        
    }
}
