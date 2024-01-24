//
//  ItemMovieTableViewCell.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import UIKit

final class ItemMovieTableViewCell: UITableViewCell {
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.setRoundedCorners()
        return view
    }()
    private let stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        return stack
    }()
    private let imageMovie: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.setRoundedCorners()
        return image
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.text = "Movie name"
        return label
    }()
    
    private let labelRelease: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .regular))
        label.text = "Movie release"
        return label
    }()
    
    
    private let labelRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.text = "Movie rate"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var task: Task<Void, Never>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
    }
    
    private func configUI() {
        
        let margins = layoutMarginsGuide
        
        addSubview(mainContainer)
        mainContainer.addSubview(imageMovie)
        mainContainer.addSubview(labelName)
        mainContainer.addSubview(labelRelease)
        mainContainer.addSubview(labelRate)
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: margins.topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5),
            mainContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            mainContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -10),
            mainContainer.heightAnchor.constraint(equalToConstant: 100),
            
            imageMovie.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 5),
            imageMovie.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 5),
            imageMovie.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -5),
            imageMovie.widthAnchor.constraint(equalToConstant: 100),
            
            labelName.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 5),
            labelName.leadingAnchor.constraint(equalTo: imageMovie.trailingAnchor, constant: 5),
            labelName.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -5),
            
            labelRelease.leadingAnchor.constraint(equalTo: imageMovie.trailingAnchor, constant: 10),
            labelRelease.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -5),
            labelRelease.widthAnchor.constraint(equalToConstant: 100),
            
            labelRate.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -5),
            labelRate.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -5),
            labelRate.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
    }
    
    func configData(model: ItemMoviesViewModel) {
        labelName.text = model.title
        labelRelease.text = DateFormater.formatDate(date: model.releaseDate)
        labelRate.text = model.iconVote.rawValue
        setImage(viewModel: model)
    }
    
    private func setImage( viewModel: ItemMoviesViewModel) {
        if let data = viewModel.imageData {
            imageMovie.setImageFromData(data: data)
        }
        else{
            task = Task {
                let dataImage = await viewModel.getImageData()
                imageMovie.setImageFromData(data: dataImage)
            }
        }
        
    }
}

//MARK: - Extensions Here
extension ItemMovieTableViewCell: Reusable { }
