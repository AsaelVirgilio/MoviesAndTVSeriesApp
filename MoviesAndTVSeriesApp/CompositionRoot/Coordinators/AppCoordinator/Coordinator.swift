//
//  Coordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit

protocol CoordinatorType: AnyObject {
    var navigationController:NavigationType { get set }
  
    func start()
}
