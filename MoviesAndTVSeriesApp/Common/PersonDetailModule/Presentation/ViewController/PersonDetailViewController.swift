//
//  PersonDetailViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 29/01/24.
//

import UIKit
import Combine

protocol PersonDetailViewControllerCoordinator: PhotosPersonViewControllerCoordinator {
    
}

final class PersonDetailViewController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let viewModel: PersonDetailViewModelType
    private var cancellable = Set<AnyCancellable>()
    private let coordinator: PersonDetailViewControllerCoordinator
    private var photosViewController: PhotosPersonViewController
    
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    
    private let birthdayAndPlaceOfBirthPerson: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: UITraitCollection(legibilityWeight: .regular))
        label.numberOfLines = 0
        return label
    }()
    
    private let biographyPerson: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: UITraitCollection(legibilityWeight: .regular))
        label.numberOfLines = 0
        return label
    }()
    
    init(photosViewController: PhotosPersonViewController,
         viewModel: PersonDetailViewModelType,
         coordinator: PersonDetailViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.photosViewController = photosViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configUserInterface()
        stateController()
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
                    self.updateUI()
                case .loading:
                    self.showSpinner()
                    print("Cargando ....")
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellable)
    }
    //MARK: - Helpers
    private func configUserInterface() {
        
        view.backgroundColor = .systemBackground
        let margins = view.layoutMarginsGuide
        photosViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        viewContainer.addSubview(photosViewController.view)
        viewContainer.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            viewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            photosViewController.view.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            photosViewController.view.leftAnchor.constraint(equalTo: viewContainer.leftAnchor),
            photosViewController.view.rightAnchor.constraint(equalTo: viewContainer.rightAnchor),
            photosViewController.view.heightAnchor.constraint(equalToConstant: 200),
            photosViewController.view.widthAnchor.constraint(equalToConstant: 300),
            
            mainStack.topAnchor.constraint(equalTo: photosViewController.view.bottomAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -30),
            mainStack.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            biographyPerson.heightAnchor.constraint(equalToConstant: 800),
            birthdayAndPlaceOfBirthPerson.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        [birthdayAndPlaceOfBirthPerson, biographyPerson].forEach { mainStack.addArrangedSubview( $0 )}
        
    }
    
    //MARK: - Actions
    
    private func updateUI() {
        
        let person = viewModel.personDetail
        let birthDay = DateFormater.formatDate(date: person?.birthday ?? "") + ", " + (person?.placeOfBirth ?? "")
        self.birthdayAndPlaceOfBirthPerson.text =  "BirthDay: \(birthDay)"
        self.biographyPerson.text = "Biography: \(person?.biography ?? "")"
        //        coordinator.showedView(actor: person)
    }
    
}

//MARK: - Extensions Here

extension PersonDetailViewController: SpinnerDisplayable {}
extension PersonDetailViewController: MessageDisplayable {}
