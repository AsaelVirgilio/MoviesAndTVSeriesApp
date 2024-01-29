//
//  VideoTrailerViewModel.swift
//  MoviesAndTVSeriesApp
//
//  Created by Asael Virgilio on 28/01/24.
//

import Combine

protocol VideoTrailerViewModelType: BaseViewModelType {
    
    var itemsVideosCount: Int { get }
    func getItemVideoViewModel(row: Int) -> ItemVideoTrailerViewModel
    
}

final class VideoTrailerViewModel: VideoTrailerViewModelType {
    
    var state: PassthroughSubject<StateController, Never>
    var itemsVideosCount: Int {
        videos.count
    }
    
    private var videos: [Video] = []
    private var loadVideoUseCase: LoadVideoTrailerUseCaseType
    
    init(
        state: PassthroughSubject<StateController, Never>,
        loadVideoUseCase: LoadVideoTrailerUseCaseType)
    {
        self.state = state
        self.loadVideoUseCase = loadVideoUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        
        Task {
            await loadVideosUseCase()
        }
        
    }
    
    func getItemVideoViewModel(row: Int) -> ItemVideoTrailerViewModel {
        makeItemVideoViewModel(row: row)
    }
    
    private func loadVideosUseCase() async {
        let resulVideos = await loadVideoUseCase.execute()
        updateStateUI(resultUseCase: resulVideos)
    }
    
    private func updateStateUI(resultUseCase: Result<[Video], Error>) {
        
        switch resultUseCase {
            
        case .success(let videos):
            self.videos.append(contentsOf: videos)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    private func makeItemVideoViewModel(row: Int) -> ItemVideoTrailerViewModel {
        var video: Video = Video(name: "Default",
                                 key: "",
                                 site: "",
                                 size: 0,
                                 type: "",
                                 official: true,
                                 publishedAt: "",
                                 id: "")
        
        if videos.count > 0 {
            video = videos[row]
        }
        
        return ItemVideoTrailerViewModel(video: video)
    }
    
}
