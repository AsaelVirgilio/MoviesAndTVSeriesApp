//
//  VideoTrailerViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Combine
import UIKit
import youtube_ios_player_helper_swift

protocol VideoTrailerViewControllerCoordinator {
    func didSelectExit()
}

final class VideoTrailerViewController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let coordinator: VideoTrailerViewControllerCoordinator
    private let viewModel: VideoTrailerViewModelType
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: VideoTrailerViewControllerCoordinator,
         viewModel: VideoTrailerViewModelType) {
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        viewModel.viewDidLoad()
        configUserInterface()
        stateController()
    }
    
    //MARK: - Helpers
    private func configUserInterface() {
        player.delegate = self
        
        view.addSubview(player)
        
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: view.topAnchor),
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            player.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            player.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func stateController() {
        
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] videos in
                guard let self = self else { return }
                self.hideSpinner()
                switch videos {
                case .success:
                    self.loadVideo()
                case .loading:
                    self.showSpinner()
                case .fail(error: let error):
                    self.presentAlert(message: error, title: AppLocalized.alertErrorTitle)
                }
            }
            .store(in: &cancellables)
        
    }
    //MARK: - Actions
    
    private func loadVideo() {
        let video = viewModel.getItemVideoViewModel(row: 0)
        _ = player.load(videoId: video.key, playerVars: ["playsinline": "0"])
    }
    
}

//MARK: - Extensions Here

extension VideoTrailerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//        playerView.playVideo()
    }
}

extension VideoTrailerViewController: SpinnerDisplayable {}
extension VideoTrailerViewController: MessageDisplayable {}
