//
//  UITextField+Extension.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

extension UITextField {
    
    func validUser() -> Bool {
        self.text?.count ?? 0 > 2 && self.text?.count ?? 0 <= 5
    }
    func validPassword() -> Bool{
        self.text?.count ?? 0 >= 3 && self.text?.count ?? 0 <= 5
    }
    
}
