//
//  ItemCastCollectionCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import UIKit

final class ItemCastCollectionCell: UICollectionViewCell {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
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
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    private let realNameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Character"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let personImage: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "movies")
        image.contentMode = .scaleToFill
        image.setRoundedCorners()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var task: Task<Void, Never>?
    
    //MARK: - Life cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configUI() {
        
        addSubview(mainContainer)
        mainContainer.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            mainContainer.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            mainStack.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            personImage.heightAnchor.constraint(equalToConstant: 150),
            realNameLabel.heightAnchor.constraint(equalToConstant: 20),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        [personImage, realNameLabel, characterNameLabel].forEach { mainStack.addArrangedSubview( $0 )
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    //MARK: - Actions
    
    func configData(viewModel: ItemCastViewModel) {
        realNameLabel.text = viewModel.originalName.capitalized
        characterNameLabel.text = viewModel.character.capitalized
        setImage(viewModel: viewModel)
    }
    
    func setImage(viewModel: ItemCastViewModel) {
        if let data = viewModel.imageData {
            personImage.setImageFromData(data: data)
        }
        else {
            task = Task {
                let dataImage = await viewModel.getImageData()
                personImage.setImageFromData(data: dataImage)
            }
        }
    }
}

//MARK: - Extensions Here
extension ItemCastCollectionCell: Reusable { }
