//
//  SeriesCollectionCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/02/24.
//

import SwiftUI
import UIKit

final class SeriesCollectionCell: SwiftUICollectionViewCell<SeriesCard> {
    //MARK: - Public Properties
    static var reuseIdentifier = "SeriesCollectionViewCell"
    
    //MARK: - Private Properties
      
    typealias Content = ItemSeriesGenresViewModel
    
    //MARK: - Life cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configure(with content: Content, parent: UIViewController) {
        embed(in: parent, withView: SeriesCard(title: content.name))
            host?.view.frame = self.contentView.bounds
        }
    
    private func configUI() {
//        backgroundColor = .blue
//        translatesAutoresizingMaskIntoConstraints = false
//        widthAnchor.constraint(equalToConstant: 100).isActive = true
//        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    //MARK: - Actions
    // MARK: UIHostingController Setup/Cleanup
        
        
    func embed(in parent: UIViewController, withContent content: Content) {
        if let host = self.host {
            host.rootView = SeriesCard(title: content.name)
            host.view.layoutIfNeeded()
        } else {
            let host = UIHostingController(rootView: SeriesCard(title: content.name))
            parent.addChild(host)
            host.didMove(toParent: parent)
            
            // alternative to using constraints
            host.view.frame = self.contentView.bounds
            self.contentView.addSubview(host.view)
            
        }
    }
        
    deinit {
            host?.willMove(toParent: nil)
            host?.view.removeFromSuperview()
            host?.removeFromParent()
        }
}

//MARK: - Extensions Here
