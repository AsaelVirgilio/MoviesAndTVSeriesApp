//
//  PhotosPersonCollectionCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//


import Foundation
import UIKit

final class PhotosPersonCollectionCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let personImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.setRoundedCorners()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var task: Task<Void, Never>?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUI() {
        addSubview(mainContainer)
        mainContainer.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            mainContainer.topAnchor.constraint(equalTo: topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainer.heightAnchor.constraint(equalToConstant: 200),
            
            mainStack.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
//            personImage.heightAnchor.constraint(equalToConstant: 100),
            
        ])
        
        mainStack.addArrangedSubview(personImage)
        
    }
    
    // MARK: - Actions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    func configData(viewModel: ItemPhotosPersonViewModel) {
        setImage(viewModel: viewModel)
    }
    
    private func setImage(viewModel: ItemPhotosPersonViewModel) {
        
        if let data = viewModel.imageData {
            personImage.setImageFromData(data: data)
        }
        else{
            task = Task {
                let dataImage = await viewModel.getImageData()
                personImage.setImageFromData(data: dataImage)
            }
        }
        
    }
}

// MARK: - Extensions here
extension PhotosPersonCollectionCell: Reusable { }

