//
//  Navigation+UIAdaptivePresentationControllerDelegate.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 22/01/24.
//


import UIKit

extension Navigation: UIAdaptivePresentationControllerDelegate {
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    dismissNavigation?()
    dismissNavigation = nil
  }
}
