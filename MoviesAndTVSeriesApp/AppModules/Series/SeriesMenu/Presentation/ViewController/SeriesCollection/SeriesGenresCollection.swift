//
//  SeriesGenresCollection.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/02/24.
//

import UIKit
import SwiftUI

protocol SeriesGenresCollectionCoordinator {
    func selectedSerieGenreCell(genre: ItemSeriesGenresViewModel)
}

final class SeriesGenresCollection: UICollectionViewController {
    
    @ObservedObject private var viewModel: SeriesGenresViewModel
    private let coordinator: SeriesGenresCollectionCoordinator?
//    private var cancellables = Set<AnyCancellable>()
    // MARK: Data
    
    init(
        collectionViewLayout: UICollectionViewLayout,
        viewModel: SeriesGenresViewModel,
        coordinator: SeriesGenresCollectionCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        viewModel.onAppear()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        stateController()
    }

    private func configCollectionView() {
        view.backgroundColor = .systemBackground
        collectionView.register(SeriesCollectionCell.self, forCellWithReuseIdentifier: SeriesCollectionCell.reuseIdentifier)
    }
    
    private func stateController() {
        if viewModel.numberOfGenres ?? 0 > 0 {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }else {
            print("---> Error \(viewModel.showErrorMessage)")
        }
    }
}

extension SeriesGenresCollection {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionCell.reuseIdentifier, for: indexPath) as? SeriesCollectionCell else { return UICollectionViewCell()}
        // Add SwiftUI UIHostingController as a child of our UIViewController
        let item = viewModel.genres[indexPath.row]
        cell.configure(with: item, parent: self)
        //        cell.embed(in: self, withContent: item)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfGenres ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSerie = viewModel.genres[indexPath.row]
        coordinator?.selectedSerieGenreCell(genre: itemSerie)
    }
}
extension SeriesGenresCollection {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 150, height: 150)
//    }
}
