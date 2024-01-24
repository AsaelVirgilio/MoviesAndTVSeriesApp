//
//  AppCoordinator.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit

final class AppCoordinator: CoordinatorType {
    var navigationController: NavigationType
    var childCoordinators: [CoordinatorType] = []
    private var appFactory: AppFactoryType?
    private let window: UIWindow?
    var auth: SessionCheckerAuth?
    
    init(navigationController: NavigationType,
         appFactory: AppFactoryType?,
         window: UIWindow?,
         auth: Auth?
    ) {
        self.navigationController = navigationController
        self.appFactory = appFactory
        self.window = window
        self.auth = auth
    }
    
    func start() {
        configWindow()
        startSomeCoordinator()
    }
    
    private func configWindow() {
        self.window?.rootViewController = navigationController.rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
      guard let auth = auth else { return }
      auth.isSessionActive ? startHomeMenuCoordinator() : startLoginCoordinator()
    }
    
    private func startHomeMenuCoordinator() {
        let mainTabBarCoordinator = appFactory?.makeHomeMenuCoordinator(navigation: navigationController, delegate: self)
      addChildCoordinatorStar(mainTabBarCoordinator)
    }
    
    private func startLoginCoordinator() {
        let loginCoordinator = appFactory?.makeLoginCoordinator(navigation: navigationController, delegate: self)
        addChildCoordinatorStar(loginCoordinator)
    } 
    // MARK: - Private helpers
    private func clearCoordinatorsAndStart() {
        navigationController.viewControllers = []
      clearAllChildsCoordinator()
      startSomeCoordinator()
    }
}

// MARK: - LogInCoordinatorDelegate
extension AppCoordinator: LoginCoordinatorDelegate {
  func didFinishLogin() {
    clearCoordinatorsAndStart()
  }
}

// MARK: - MainTabBarCoordinatorDelegate
extension AppCoordinator: HomeMenuCoordinatorDelegate {
  func didFinish() {
    clearCoordinatorsAndStart()
  }
}

extension AppCoordinator: ParentCoordinator { }
