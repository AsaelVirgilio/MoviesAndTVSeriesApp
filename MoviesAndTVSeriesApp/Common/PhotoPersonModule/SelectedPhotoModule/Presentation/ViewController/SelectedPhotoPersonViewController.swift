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
    private var idPhoto: IndexPath
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
         viewModel: SelectedPhotoPersonViewModelType,
         idPhoto: IndexPath
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.idPhoto = idPhoto
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        viewModel.viewDidLoad()
        configCollectionView()
    }
    
    
    //MARK: - Helpers
    
    private func configCollectionView() {
        view.backgroundColor = .systemBackground
        collectionView.register(SelectedPhotoCollectionCell.self, forCellWithReuseIdentifier: SelectedPhotoCollectionCell.reuseIdentifier)
        collectionView.scrollToItem(at: idPhoto, at: .centeredHorizontally, animated: true)
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
