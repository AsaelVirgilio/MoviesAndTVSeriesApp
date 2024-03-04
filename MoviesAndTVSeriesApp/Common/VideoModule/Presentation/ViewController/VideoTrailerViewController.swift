//
//  VideoTrailerViewController.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Combine
import UIKit

protocol VideoTrailerViewControllerCoordinator {
    func didSelectExit()
}
protocol VideoPlayerType: VideoPlayerYTPlayerViewType {
    func loadVideo(key: String)
}

import youtube_ios_player_helper_swift
protocol VideoPlayerYTPlayerViewType {
    func getPlayer() -> YTPlayerView
}

public class VideoPlayerYTPlayerView: VideoPlayerType  {
    
    private var player: YTPlayerView = YTPlayerView()
    
    func getPlayer() -> YTPlayerView {
        player
    }
    
    func loadVideo(key: String) {
        _ = player.load(videoId: key, playerVars: ["playsinline": "0"])
    }
    
}

final class VideoTrailerViewController: UIViewController {
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    private let coordinator: VideoTrailerViewControllerCoordinator
    private let viewModel: VideoTrailerViewModelType
    private var cancellables = Set<AnyCancellable>()
    private var videoPlayer: VideoPlayerType
    
    init(videoPlayer: VideoPlayerType,
         coordinator: VideoTrailerViewControllerCoordinator,
         viewModel: VideoTrailerViewModelType) {
        self.videoPlayer = videoPlayer
        self.coordinator = coordinator
        self.viewModel = viewModel
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
    
    //MARK: - Helpers
    private func configUserInterface() {
//        player.delegate = self
        
        videoPlayer.getPlayer().translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoPlayer.getPlayer())
        
        NSLayoutConstraint.activate([
            videoPlayer.getPlayer().topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.getPlayer().leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoPlayer.getPlayer().trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoPlayer.getPlayer().bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func stateController() {
        
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] videos in
                guard let self = self else { return }
                self.hideSpinner()
                print("----> Se oculta spinner de trailer")
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
    func loadVideo() {
        let video = viewModel.getItemVideoViewModel(row: 0)
        videoPlayer.loadVideo(key: video.key)
    }
    
}

//MARK: - Extensions Here

extension VideoTrailerViewController: SpinnerDisplayable {}
extension VideoTrailerViewController: MessageDisplayable {}
