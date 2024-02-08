//
//  SearchMediaSearchController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import UIKit
protocol SearchMediaSearchControllerCoordinator {
    func sendToSearch(searchInfo: [String:Any])
}

final class SearchMediaSearchController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let imageBack: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .systemGray6
        return image
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        return label
    }()
    
    private let coordinator: SearchMediaSearchControllerCoordinator
    private let itemGenre: ItemMoviesGenresViewModel
    //MARK: - Life cicle
    
    init(coordinator: SearchMediaSearchControllerCoordinator,
         itemGenre: ItemMoviesGenresViewModel
    ) {
        self.coordinator = coordinator
        self.itemGenre = itemGenre
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        updateUI()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        let margins = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        view.addSubview(mainContainer)
        mainContainer.addSubview(imageBack)
        mainContainer.addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: margins.topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            imageBack.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            imageBack.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            imageBack.widthAnchor.constraint(equalToConstant: 200),
            imageBack.heightAnchor.constraint(equalToConstant: 300),
            
            genreLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40),
            genreLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            genreLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    //MARK: - Actions
    private func updateUI() {
        genreLabel.text = itemGenre.name
    }
}

//MARK: - Extensions Here
extension SearchMediaSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.searchTextField.text else { return }
        
        let searchInfo: [String:Any] = ["key": key, "idGenre": itemGenre.idGenre]
        coordinator.sendToSearch(searchInfo: searchInfo)
    }
    
}
