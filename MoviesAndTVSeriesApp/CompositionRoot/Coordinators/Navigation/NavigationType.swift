//
//  Navigation.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 22/01/24.
//

import UIKit

protocol NavigationType {
  var rootViewController: UINavigationController { get }
  var viewControllers: [UIViewController] { get set }
  var navigationBar: UINavigationBar { get }
  func present(_ viewControllerToPresent: UIViewController, animated: Bool)
  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool, backCompletion: (() -> Void)?
  )
  func dismiss(animated: Bool)
  var dismissNavigation: (() -> Void)? { get set }
}

extension NavigationType {
  func pushViewController(_ viewControllerToPresent: UIViewController, animated: Bool) {
    pushViewController(viewControllerToPresent, animated: animated, backCompletion: nil)
  }
}
