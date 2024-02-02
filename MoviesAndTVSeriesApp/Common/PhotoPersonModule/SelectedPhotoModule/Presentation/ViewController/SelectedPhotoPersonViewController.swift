//
//  SelectedPhotoPersonViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 01/02/24.
//

import Foundation
import UIKit

protocol SelectedPhotosPersonViewControllerCoordinator {
    func didDisapperView()
}

final class SelectedPhotoPersonViewController: UICollectionViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private var coordinator: SelectedPhotosPersonViewControllerCoordinator
    private let viewModel: SelectedPhotoPersonViewModelType
    
    private var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    
    //MARK: - Life cicle
    
    init(layout: UICollectionViewLayout,
        coordinator: SelectedPhotosPersonViewControllerCoordinator,
         viewModel: SelectedPhotoPersonViewModelType
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        viewModel.viewDidLoad()
        configCollectionView()
    }
    
    
    //MARK: - Helpers
    
    private func configCollectionView() {
        view.backgroundColor = .systemBackground
//        view.addSubview(pageControl)
//        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        collectionView.register(SelectedPhotoCollectionCell.self, forCellWithReuseIdentifier: SelectedPhotoCollectionCell.reuseIdentifier)
        
    }
    //MARK: - Actions
    
}

//MARK: - Extensions Here
extension SelectedPhotoPersonViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfPhotos
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedPhotoCollectionCell.reuseIdentifier, for: indexPath) as? SelectedPhotoCollectionCell else {
            return UICollectionViewCell()
        }
        
        let itemModel = viewModel.getItemSelectedPhoto(index: indexPath.row)
        cell.configData(viewModel: itemModel)
        
        return cell
    }
}
