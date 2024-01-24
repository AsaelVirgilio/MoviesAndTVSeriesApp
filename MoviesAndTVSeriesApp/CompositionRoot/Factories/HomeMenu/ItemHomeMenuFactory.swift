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
    image: String,
    selectedImage: String
  ) {
  
    let tabBarItem = UITabBarItem(
      title: title,
      image: UIImage(named: image),
      selectedImage: UIImage(systemName: selectedImage))
    
    navigation.rootViewController.tabBarItem = tabBarItem
  }
}
