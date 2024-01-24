//
//  BaseViewModelType.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import Combine

protocol BaseViewModelType {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}
