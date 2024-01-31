//
//  UIImageView+Utils.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import UIKit
extension UIImageView {
    func setImageFromData( data: Data?) {
        if let data = data {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
    
    func addDefaultImage() {
        image = UIImage(named: "default")
        
    }
}
