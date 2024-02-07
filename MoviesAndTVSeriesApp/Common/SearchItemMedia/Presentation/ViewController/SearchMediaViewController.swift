//
//  SearchMediaViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 06/02/24.
//

import Combine
import UIKit

protocol SearchMediaViewControllerCoordinator {
    func didSelectCell(movie: SearchResults)
    
}

import UIKit

final class SearchMediaViewController: UITableViewController {
    
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    
    private let viewModel: SearchMediaViewModelType
    private let coordinator: SearchMediaViewControllerCoordinator
    private var cancellables = Set<AnyCancellable>()
    //MARK: - Life cicle
    
    init(viewModel: SearchMediaViewModelType,
         coordinator: SearchMediaViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configTableView()
        stateController()
    }
    
    //MARK: - Helpers
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(ItemSearchTableViewCell.self, forCellReuseIdentifier: ItemSearchTableViewCell.reuseIdentifier)
        addSpinnerLastCell()
        
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                self.hideSpinner()
                switch state {
                    
                case .success:
                    self.tableView.reloadData()
                case .loading:
                    self.showSpinner()
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Actions
    
}

//MARK: - Extensions Here
extension SearchMediaViewController: SpinnerDisplayable {}
extension SearchMediaViewController: MessageDisplayable {}


extension SearchMediaViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSearchTableViewCell.reuseIdentifier, for: indexPath) as? ItemSearchTableViewCell else {
            return UITableViewCell()
            
        }
        let row = indexPath.row
        let model = viewModel.getItemSearchMediaViewModel(row: row)
        cell.configData(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMediaViewModel(row: indexPath.row)
        coordinator.didSelectCell(movie: movie)
    }
}


