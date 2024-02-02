//
//  SelectedPhotoCollectionCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Foundation
import UIKit

final class SelectedPhotoCollectionCell: UICollectionViewCell {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setRoundedCorners()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life cicle
    private var task: Task<Void, Never>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configUI() {
        
//        let margins = layoutMarginsGuide
        addSubview(viewContainer)
        viewContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -5),
            
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    //MARK: - Actions
    
    func configData(viewModel: ItemSelectedPhoto) {
        setImage(viewModel: viewModel)
    }
    
    private func setImage(viewModel: ItemSelectedPhoto) {
        if let data = viewModel.imageData {
            print("------> de Data")
            imageView.setImageFromData(data: data)
        }
        else{
            task = Task {
                print("------> de Data remote")
                let dataImage = await viewModel.getImageData()
                imageView.setImageFromData(data: dataImage)
            }
        }
    }
}

//MARK: - Extensions Here

extension SelectedPhotoCollectionCell: Reusable { }
