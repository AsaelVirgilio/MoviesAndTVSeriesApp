//
//  LocalDataImageService.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//


import Foundation

protocol LocalDataImageServiceType {
    func save(key: String, data: Data?)
    func get(key: String) -> Data?
}

struct LocalDataImageService: LocalDataImageServiceType {
    private var dataStorage = NSCache<NSString, NSData>()
    
    func save(key: String, data: Data?) {
        guard let data = data else { return }
        dataStorage.setObject(data as NSData, forKey: key as NSString)
    }
    
    func get(key: String) -> Data? {
        dataStorage.object(forKey: key as NSString) as? Data
    }
}
