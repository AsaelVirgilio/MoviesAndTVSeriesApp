//
//  ItemHomeMenuFactory.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 23/01/24.
//

import UIKit

protocol ItemHomeMenuFactory { }

extension ItemHomeMenuFactory {
  func makeItemHomeMenu(
    navigation: NavigationType,
    title: String,
    image: String
  ) {
    let tabBarItem = UITabBarItem(
      title: title,
      image: UIImage(named: image),
      tag: 0)
    
    navigation.rootViewController.tabBarItem = tabBarItem
  }
}
