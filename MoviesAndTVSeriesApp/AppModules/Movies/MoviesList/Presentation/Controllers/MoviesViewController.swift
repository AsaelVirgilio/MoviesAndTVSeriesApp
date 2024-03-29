//
//  MoviesViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 24/01/24.
//

import UIKit
import Combine

protocol MoviesViewControllerCoordinator {
    func didSelectCell(movie: Movie)
    func pushedSearchButton()
}

final class MoviesViewController: UITableViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewModel: MoviesViewModelType
    private var cancellables = Set<AnyCancellable>()
    private let coordinator: MoviesViewControllerCoordinator
    
    //MARK: - Life cicle
    
    init(viewModel: MoviesViewModelType,
         coordinator: MoviesViewControllerCoordinator
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
        let image = UIImage(systemName: "magnifyingglass")
        let barButtonItem = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: #selector(goToSearch))
        navigationItem.rightBarButtonItem = barButtonItem
        tableView.register(ItemMovieTableViewCell.self, forCellReuseIdentifier: ItemMovieTableViewCell.reuseIdentifier)
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
                    print("Loading movies...")
//                    self.showSpinner()
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.okButton)
                }
            }
            .store(in: &cancellables)
    }
    //MARK: - Actions
    @objc
    private func goToSearch() {
        coordinator.pushedSearchButton()
    }
    
}
extension MoviesViewController: SpinnerDisplayable {}
extension MoviesViewController: MessageDisplayable {}

extension MoviesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemsMoviesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemMovieTableViewCell.reuseIdentifier, for: indexPath) as? ItemMovieTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        let model = viewModel.getItemMoviesViewModel(row: row)
        cell.configData(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.getMovieViewModel(row: indexPath.row)
        coordinator.didSelectCell(movie: movie)
    }
}
