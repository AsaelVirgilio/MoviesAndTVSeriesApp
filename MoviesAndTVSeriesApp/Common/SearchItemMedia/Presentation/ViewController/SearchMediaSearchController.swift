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
    
    private let coordinator: SearchMediaSearchControllerCoordinator
    private let idGenre: Int
    //MARK: - Life cicle
    
    init(coordinator: SearchMediaSearchControllerCoordinator,
         idGenre: Int
    ) {
        self.coordinator = coordinator
        self.idGenre = idGenre
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        let margins = view.layoutMarginsGuide
        view.backgroundColor = .systemBackground
        view.addSubview(mainContainer)
        mainContainer.addSubview(imageBack)
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: margins.topAnchor),
            mainContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            imageBack.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            imageBack.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            imageBack.widthAnchor.constraint(equalToConstant: 200),
            imageBack.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    //MARK: - Actions
}

//MARK: - Extensions Here
extension SearchMediaSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let key = searchBar.searchTextField.text else { return }
        
        let searchInfo: [String:Any] = ["key": key, "idGenre": idGenre]
        coordinator.sendToSearch(searchInfo: searchInfo)
    }
    
}
