//
//  MovieIntroViewModel.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import Foundation
import Combine

class MovieIntroViewModel: ObservableObject {
    @Published var detail: DetailResponse?
    @Published var video: Video?
    @Published var posters: [Poster]?
    @Published var similar: SimilarResponse?
    
    private let networkService: NetworkProtocol
    private let apiRequest: MovieRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, apiRequest: MovieRequestProtocol) {
        self.networkService = networkService
        self.apiRequest = apiRequest
    }
    
    func fetchDetail(movieId: Int) {
        let request = apiRequest.createDetail(movieId: movieId)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] (response: DetailResponse) in
                self?.detail = response
            }
            .store(in: &cancellables)
    }
    
    func fetchVideo(movieId: Int) {
        let request = apiRequest.createVideo(movieId: movieId)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] (response: VideoResponse) in
                let isOfficialTrailer: (Video) -> Bool = { $0.name.contains("Official") && $0.videoType == .trailer }
                
                if let officialTrailer = response.results.first(where: isOfficialTrailer) {
                    self?.video = officialTrailer
                } else {
                    self?.video = response.results.first(where: { $0.videoType == .trailer })
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchImages(movieId: Int) {
        let request = apiRequest.createImages(movieId: movieId)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] (response: ImagesResponse) in
                self?.posters = response.posters
            }
            .store(in: &cancellables)
    }
    
    func fetchSimilar(movieId: Int) {
        let request = apiRequest.createSimilar(movieId: movieId)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { [weak self] (response: SimilarResponse) in
                self?.similar = response
            }
            .store(in: &cancellables)
    }
}
