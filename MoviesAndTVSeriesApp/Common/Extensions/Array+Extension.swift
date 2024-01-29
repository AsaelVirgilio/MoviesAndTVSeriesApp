//
//  Array+Extension.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 26/01/24.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeFirstOccurrence(of element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
}
