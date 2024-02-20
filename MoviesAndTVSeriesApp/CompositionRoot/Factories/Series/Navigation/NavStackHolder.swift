//
//  NavStackHolder.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 09/02/24.
//

import SwiftUI

public class NavStackHolder {
  public weak var viewController: UIViewController?
  
  public init() {}
}

public protocol ViewControllable: View {
  var holder: NavStackHolder { get set }
  
  func loadView()
  func viewOnAppear(viewController: UIViewController)
}

