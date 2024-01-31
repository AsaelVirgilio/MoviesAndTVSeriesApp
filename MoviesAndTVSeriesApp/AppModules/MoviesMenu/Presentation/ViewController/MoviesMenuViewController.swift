//
//  MoviesMenuViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 20/01/24.
//

import UIKit
import Combine

protocol MoviesMenuViewControllerCoordinator {
    func selectedMovieGenreCell(genre: ItemMoviesGenresViewModel)
}

final class MoviesMenuViewController: UICollectionViewController {
    private let viewModel: MoviesGenresViewModelType
    private let coordinator: MoviesMenuViewControllerCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(collectionViewLayout: UICollectionViewLayout,
         viewModel: MoviesGenresViewModelType,
         coordinator: MoviesMenuViewControllerCoordinator
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
        configUI()
        configCollectionView()
        stateController()
        viewModel.viewDidLoad()
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
    }

    private func configCollectionView() {
        collectionView.register(ItemMoviesGenresCell.self, forCellWithReuseIdentifier: ItemMoviesGenresCell.reuseIdentifier)
    }
    
    private func stateController() {
        viewModel
            .state
            .sink { [weak self] state in
                guard let self = self else { return }
//                self.hideSpinner()
                switch state {
                    
                case .success:
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .loading:
//                    self.showSpinner()
                    print("---> cargando moviesMenu")
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellables)
    }
}

extension MoviesMenuViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemMoviesGenresCell.reuseIdentifier, for: indexPath) as? ItemMoviesGenresCell else { return UICollectionViewCell()}
        
        let model = viewModel.getItemMovieGenreViewModel(row: indexPath.row)
        cell.configData(viewModel: model)
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsMovieGenresCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.getItemMovieGenreViewModel(row: indexPath.row)
        coordinator.selectedMovieGenreCell(genre: item)
    }
}
//extension MoviesMenuViewController: SpinnerDisplayable {}
extension MoviesMenuViewController: MessageDisplayable {}
