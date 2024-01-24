//
//  HomeMenuController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//


import UIKit

protocol HomeMenuControllerCoordinator: AnyObject {
  func didFinish()
}

class HomeMenuController: UITabBarController {
    
//    private let coordinator: HomeMenuControllerCoordinator
//    private let user: UserDTO
//    
//    init(coordinator: HomeMenuControllerCoordinator,
//         user: UserDTO
//    ) {
//        self.coordinator = coordinator
//        self.user = user
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    //MARK:- Setup Functions
    
    func setupViewControllers() {
        view.backgroundColor = .systemBackground
    }
//        tabBar.tintColor = .systemBlue
//        
//        guard let moviesImage = UIImage(named: AppLocalized.moviesTapIcon) else { return }
//        guard let seriesImage = UIImage(named: AppLocalized.seriesTapIcon) else { return }
//        
//        viewControllers = [
//            generateNavigationController(for: LoginViewController2(), title: AppLocalized.moviesTapTitle, image: moviesImage),
//            generateNavigationController(for: ViewController(), title: AppLocalized.seriesTapTitle, image: seriesImage),
//        ]
//    }
//    
//    //MARK:- Helper Functions
//    
//    fileprivate func generateNavigationController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
//        let navController = UINavigationController(rootViewController: rootViewController)
////        navController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = image
//        return navController
//    }
//    
    
}

