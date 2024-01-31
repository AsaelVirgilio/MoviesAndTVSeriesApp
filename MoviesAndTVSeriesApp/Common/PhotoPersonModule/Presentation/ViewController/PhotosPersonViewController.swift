//
//  PhotosPersonViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 30/01/24.
//

import Combine
import UIKit

protocol PhotosPersonViewControllerCoordinator {
    func didSelectPhoto(photoPath: String)
}

final class PhotosPersonViewController: UICollectionViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewModel: PhotosPersonViewModelType
    private var coordinator: PhotosPersonViewControllerCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        stateController()
        viewModel.viewDidLoad()
    }
    
    init(collectionViewLayout: UICollectionViewLayout,
         viewModel: PhotosPersonViewModelType,
         coordinator: PhotosPersonViewControllerCoordinator?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configCollectionView() {
        view.backgroundColor = .systemBackground
        
        collectionView.register(PhotosPersonCollectionCell.self, forCellWithReuseIdentifier: PhotosPersonCollectionCell.reuseIdentifier)
        
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                guard let self = self else {return}
//                self.hideSpinner()
                
                switch response {
                case .success:
                    self.collectionView.reloadData()
                    print("-------> No Errrrrrroooooooorrrrr")
                case .loading:
                    print("-------> Loadiiiiing")
//                    self.showSpinner()
                case .fail(error: let error):
                    presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Actions
    
}

extension PhotosPersonViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosPersonCollectionCell.reuseIdentifier, for: indexPath) as? PhotosPersonCollectionCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.getItemPhotosPersonViewModel(row: indexPath.row)
        cell.configData(viewModel: model)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemPhotosCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItemPhotosPersonViewModel(row: indexPath.row)
        coordinator?.didSelectPhoto(photoPath: item.filePath)
    }
    
}

//MARK: - Extensions Here

//extension PhotosPersonViewController: SpinnerDisplayable {}
extension PhotosPersonViewController: MessageDisplayable {}
