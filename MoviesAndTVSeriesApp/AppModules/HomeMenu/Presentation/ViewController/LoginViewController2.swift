//
//  ViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 18/01/24.
//

import UIKit
import youtube_ios_player_helper_swift

protocol LoginViewController2Coordinator {
    
}

final class LoginViewController2: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let coordinator: LoginViewController2Coordinator
    
    init(coordinator: LoginViewController2Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let player: YTPlayerView = {
        let player = YTPlayerView()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        player.delegate = self
        _ = player.load(videoId: "ZaTUatY-UoU", playerVars: ["playsinline": "1"])
        configUserInterface()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        let margins = view.layoutMarginsGuide
        view.addSubview(player)
        
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: margins.topAnchor, constant: 200),
            player.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant:  50),
            player.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -50),
            
            player.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    //MARK: - Actions
    
}

//MARK: - Extensions Here

extension LoginViewController2: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
