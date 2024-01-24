//
//  ApiError.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Foundation

enum ApiError: Error {
    case clientError
    case serverError
    case unknowError
    case errorInURL
    case errorDecoding
}

extension ApiError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .clientError:
            return NSLocalizedString("Client error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .unknowError:
            return NSLocalizedString("Unknow error", comment: "")
        case .errorInURL:
            return NSLocalizedString("URL invalid error", comment: "")
        case .errorDecoding:
            return NSLocalizedString("Decoding error", comment: "")
        }
    }
}
