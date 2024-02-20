//
//  ViewControllable+Extension.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import UIKit

public extension ViewControllable {
  var viewController: UIViewController {
    let viewController = HostingController(rootView: self)
    self.holder.viewController = viewController
    return viewController
  }
  
  func loadView() {}
  func viewOnAppear(viewController: UIViewController) {}
}
