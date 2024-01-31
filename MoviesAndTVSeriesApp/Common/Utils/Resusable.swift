//
//  Resusable.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

protocol Reusable {}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
