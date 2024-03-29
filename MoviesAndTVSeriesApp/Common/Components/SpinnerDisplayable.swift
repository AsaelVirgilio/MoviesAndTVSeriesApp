//
//  SpinnerDisplayable.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import UIKit

protocol SpinnerDisplayable {
    func showSpinner()
    func hideSpinner()
}
extension SpinnerDisplayable where Self : UIViewController {
    
    func showSpinner () {
        guard doesNotExistAnotherSpinner else { return }
        configureSpinner ()
    }
    
    private func configureSpinner() {
        let containerView = UIView()
        containerView.tag = ViewValues.tagIdentifierSpinner
        parentView.addSubview(containerView)
        containerView.fillSuperView()
        containerView.backgroundColor = .black.withAlphaComponent (ViewValues.opacityContainerSpinner)
        addSpinnerIndicatorToContainer(containerView: containerView)
    }
    
    private func addSpinnerIndicatorToContainer(containerView: UIView) {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        containerView.addSubview(spinner)
        spinner.centerXY()
    }
    
    func hideSpinner(){
        if let foundView = parentView.viewWithTag(ViewValues.tagIdentifierSpinner) {
            foundView.removeFromSuperview()
        }
    }
    
    private var doesNotExistAnotherSpinner: Bool {
        parentView.viewWithTag(ViewValues.tagIdentifierSpinner) == nil
    }
    
    private var parentView: UIView {
        navigationController?.view ?? view
    }
    
}
