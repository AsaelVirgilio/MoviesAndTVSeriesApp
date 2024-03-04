//
//  FlowError.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 02/03/24.
//

import Foundation

enum FlowError: Error {
    case noResultsError
}


extension FlowError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noResultsError:
            return NSLocalizedString("No results", comment: "")
        }
    }
}
