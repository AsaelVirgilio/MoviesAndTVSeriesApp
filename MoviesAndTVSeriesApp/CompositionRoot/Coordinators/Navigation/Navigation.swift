//
//  Navigation.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 22/01/24.
//

import UIKit

final class Navigation: NSObject {
  var rootViewController: UINavigationController
  var dismissNavigation: (() -> Void)?
  var backCompletions: [UIViewController: () -> Void] = [ : ]
  
  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController
    super.init()
    rootViewController.delegate = self
    rootViewController.presentationController?.delegate = self
  }
}

extension Navigation: NavigationType {
  var viewControllers: [UIViewController] {
    get {
      rootViewController.viewControllers
    }
    set {
      rootViewController.viewControllers = newValue
    }
  }
  
  var navigationBar: UINavigationBar {
    rootViewController.navigationBar
  }
  
  func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
    rootViewController.present(viewControllerToPresent, animated: animated)
  }
  
  func dismiss(animated: Bool) {
    rootViewController.dismiss(animated: animated)
  }
  
  func pushViewController(
    _ viewControllerToPresent: UIViewController,
    animated: Bool, backCompletion: (() -> Void)?
  ) {
    if let backCompletion = backCompletion {
      backCompletions[viewControllerToPresent] = backCompletion
    }
    rootViewController.pushViewController(viewControllerToPresent, animated: animated)
  }
}

