//
//  MovieDetailViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 27/01/24.
//

import Combine
import UIKit

protocol MovieDetailViewControllerCoordinator: VideoTrailerViewControllerCoordinator, CastViewControllerCoordinator {
    func didFinishDetail()
}

final class MovieDetailViewController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewModel: MovieDetailViewModelType
    private let coordinator: MovieDetailViewControllerCoordinator
    private var cancellable = Set<AnyCancellable>()
    private let videoTrailerViewController: VideoTrailerViewController
    private let castViewController: CastViewController
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.setRoundedCorners(round: 10, halfView: true)
        return view
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textAlignment = .center
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 20
        return stack
    }()
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleToFill
        imageView.setRoundedCorners()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieOverview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: UITraitCollection(legibilityWeight: .regular))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.preferredMaxLayoutWidth = 200
        return label
    }()
    
    //MARK: - Life cicle
    
    init(videoTrailerViewController: VideoTrailerViewController,
         viewModel: MovieDetailViewModelType,
         coordinator: MovieDetailViewControllerCoordinator,
         castViewController: CastViewController
    ) {
        self.videoTrailerViewController = videoTrailerViewController
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.castViewController = castViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        stateController()
        configUserInterface()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator.didFinishDetail()
    }
    //MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
//        let margins = view.layoutMarginsGuide
        videoTrailerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        castViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.addSubview(headerTitle)
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        
        viewContainer.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            headerTitle.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20),
            headerTitle.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -20),
            headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            viewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainStack.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            
            movieOverview.heightAnchor.constraint(equalToConstant: 200),
            
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            
            videoTrailerViewController.view.heightAnchor.constraint(equalToConstant: 300),
            
            castViewController.view.heightAnchor.constraint(equalToConstant: 300),
            
        ])
        
        [movieImage, movieOverview, videoTrailerViewController.view, castViewController.view].forEach { mainStack.addArrangedSubview($0)}
        
    }
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.hideSpinner()
                switch result {
                case .success:
                    self.configData()
                case .loading:
                    self.showSpinner()
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellable)
    }
    
    //MARK: - Actions
    private func configData() {
        let itemMovieDetailViewModel = viewModel.getItemMovieDetailViewModel()
        self.headerTitle.text = itemMovieDetailViewModel.originalTitle
        let texto = itemMovieDetailViewModel.overview
        self.movieOverview.text = texto
        self.setImage(viewModel: itemMovieDetailViewModel)
    }
    private func setImage(viewModel: ItemMovieDetailViewModel?)  {
        self.movieImage.addDefaultImage()
        if let data = viewModel?.backdropData {
            movieImage.setImageFromData(data: data)
        }
        else{
            Task {
                let dataImage = await viewModel?.getBackdropData()
                movieImage.setImageFromData(data: dataImage)
            }
        }
    }
}

//MARK: - Extensions Here

extension MovieDetailViewController: SpinnerDisplayable {}
extension MovieDetailViewController: MessageDisplayable {}
