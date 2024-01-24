//
//  ImageDataRepository.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import Foundation

struct ImageDataRepository: ImageDataRepositoryType {
    
    private(set) var remoteDataService: RemoteImageDataServiceType
    private(set) var localDataCache: LocalDataImageServiceType
    
    func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataService.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    func getFromCache(url: String?) -> Data? {
        localDataCache.get(key: url ?? .empty)
    }
}
