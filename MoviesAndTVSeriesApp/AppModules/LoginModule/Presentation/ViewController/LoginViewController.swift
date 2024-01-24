//
//  LoginViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 19/01/24.
//

import Combine
import UIKit

protocol LoginViewControllerCoordinator {
    func loginSuccess(user: UserDTO)
}

final class LoginViewController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let coordinator: LoginViewControllerCoordinator
    private let viewModel: LoginViewModelType
    private var cancellables = Set<AnyCancellable>()
    
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.setRoundedCorners(round: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.contentMode = .scaleAspectFit
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let userField: UITextField = {
        let field = UITextField()
        field.placeholder = AppLocalized.phUsername
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passField: UITextField = {
        let field = UITextField()
        field.placeholder = AppLocalized.phPassword
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(AppLocalized.loginBtn, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let biometricButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(AppLocalized.biometricBtn, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - Life cicle
    
    init(coordinator: LoginViewControllerCoordinator,
         viewModel: LoginViewModelType) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configUserInterface()
        stateController()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        self.loginButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.biometricButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let margins = view.layoutMarginsGuide
        
        view.addSubview(viewContainer)
        viewContainer.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            viewContainer.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100),
            viewContainer.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            viewContainer.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            viewContainer.heightAnchor.constraint(equalToConstant: 400),
            
            stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            userField.heightAnchor.constraint(equalToConstant: 50),
            passField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            biometricButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        [userField, passField, loginButton, biometricButton, UIView()].forEach { stackView.addArrangedSubview( $0 )}
    }
    
    private func stateController() {
        viewModel
            .state
            .sink { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .success:
                    sendToNextModule()
                case .loading:
                    break
                case .fail(error: let error):
                    presentAlert(message: "Alert", title: error.capitalized)
                }
                
            }
            .store(in: &cancellables)
    }
    
    func sendToNextModule() {
        let user = viewModel.getUser()
        coordinator.loginSuccess(user: user)
    }
    
    //MARK: - Actions
    @objc
    private func buttonAction(_ sender: UIButton){
        
        switch sender.titleLabel?.text {
        case AppLocalized.loginBtn:
            if userField.validUser() && passField.validPassword() {
                let credential = UserCredential(username: userField.text ?? "", password: passField.text ?? "")
                viewModel.validateUser(credential: credential)
            }
            else{
                loginAction(message: AppLocalized.invalidCredential)
            }
        case AppLocalized.biometricBtn:
            print("button biometric pressed")
        default:
            print("Unknow button pressed")
        }
    }
    
    func loginAction(message: String) {
        presentAlert(message: message, title: AppLocalized
            .alertErrorTitle)
    }
}

//MARK: - Extensions Here

//extension LoginViewController: SpinnerDisplayable{}
extension LoginViewController: MessageDisplayable{}
