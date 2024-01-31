//
//  CastViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import UIKit
import Combine

protocol CastViewControllerCoordinator {
    func didSelectPersonCell(itemCastViewModel: ItemCastViewModel)
}

final class CastViewController: UICollectionViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewModel: CastViewModelType
    private var coordinator: CastViewControllerCoordinator?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Life cicle
    
    init(collectionViewLayout: UICollectionViewLayout,
         viewModel: CastViewModelType,
         coordinator: CastViewControllerCoordinator?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        stateController()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        collectionView.register(ItemCastCollectionCell.self, forCellWithReuseIdentifier: ItemCastCollectionCell.reuseIdentifier)
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                self?.hideSpinner()
                switch state {
                case .success:
                    self?.collectionView.reloadData()
                case .loading:
                    self?.showSpinner()
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: "Error")
                }
            }
            .store(in: &cancellables)
    }
    //MARK: - Actions
    
}

//MARK: - Extensions Here

extension CastViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCastCollectionCell.reuseIdentifier, for: indexPath) as? ItemCastCollectionCell else {
            return UICollectionViewCell()
        }
        let model = viewModel.getItemMenuViewModel(row: indexPath.row)
        cell.configData(viewModel: model)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemPersonsCount
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.getItemMenuViewModel(row: indexPath.row)
        coordinator?.didSelectPersonCell(itemCastViewModel: model)
    }
}

extension CastViewController: SpinnerDisplayable {}
extension CastViewController: MessageDisplayable {}
