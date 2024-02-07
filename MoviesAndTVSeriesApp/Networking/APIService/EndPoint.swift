//
//  EndPoint.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import Foundation

struct EndPoint {
    static let baseURL = "https://api.themoviedb.org/3/"
}


struct ApiKey {
    static let apiKey = "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}

enum URLPath {
    case moviesGenres
    case tvGenres
    case moviesTrending
    case movieCredits
    case tvTrending
    case tvCredits
    case personInfo
    case personImages
    case moviesTrailers
    
}
enum URLPathSearch {
    
    case searchMovie
    case searchSerie
    
}

struct PathLocalized {
    
    static let genresMovies = "genre/movie/list?"
    static let genresTV = "genre/tv/list?"
    static let trendingMovies = "trending/movie/week?"
    static let movie = "movie/"
    static let trendingTv = "trending/tv/week?"
    static let tv = "tv/"
    static let person = "person/"
    static let credits = "credits?"
    static let images = "images?"
    static let searchMovie = "search/movie?query="
    static let searchTv = "/search/tv?query="
    static let moviesTrailers = "videos?"
    
    static func createURL(path: URLPath, id: Int = 0) -> String {
        switch path {
        case .moviesTrending:
            return EndPoint.baseURL + trendingMovies + ApiKey.apiKey + "&page=\(id)"
        case .movieCredits:
            return EndPoint.baseURL + movie + "\(id)/" + credits + ApiKey.apiKey
        case .tvTrending:
            return EndPoint.baseURL + trendingTv + ApiKey.apiKey + "&page=\(id)"
        case .tvCredits:
            return EndPoint.baseURL + tv + "\(id)/" + credits + ApiKey.apiKey
        case .personInfo:
            return EndPoint.baseURL + person + "\(id)?" + ApiKey.apiKey
        case .personImages:
            return EndPoint.baseURL + person + "\(id)/" + images + ApiKey.apiKey
        case .moviesTrailers:
            return EndPoint.baseURL + movie + "\(id)/" + moviesTrailers + ApiKey.apiKey
        case .moviesGenres:
            return EndPoint.baseURL + genresMovies + ApiKey.apiKey
        case .tvGenres:
            return EndPoint.baseURL + genresTV + ApiKey.apiKey
        }
    }
    
    static func createURLSearch(path: URLPathSearch, keyword: String, page: Int) -> String {
        switch path {
        case .searchMovie:
            return EndPoint.baseURL + searchMovie + "\(keyword)/" + "&page=\(page)&" + ApiKey.apiKey
        case .searchSerie:
            return EndPoint.baseURL + searchTv + "\(keyword)/" + "&page=\(page)&" + ApiKey.apiKey
        }
    }
}
/*
 
 https://api.themoviedb.org/3/genre/movie/list?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a
 
 https://api.themoviedb.org/3/genre/tv/list?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a
 
 
 */
