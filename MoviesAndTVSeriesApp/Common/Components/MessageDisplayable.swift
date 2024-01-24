//
//  MessageDisplayable.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

protocol MessageDisplayable {
    func presentAlert(message: String, title: String)
}

extension MessageDisplayable where Self: UIViewController {
    func presentAlert(message: String, title: String){
        let alertController = UIAlertController (
        title: title,
        message: message,
        preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: AppLocalized.okButton, style: .default)
        alertController.addAction( okAction)
        self.present(alertController, animated: true)
    }
}
