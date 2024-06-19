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
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkProtocol
    private let apiRequest: MovieRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, apiRequest: MovieRequestProtocol) {
        self.networkService = networkService
        self.apiRequest = apiRequest
    }
    
    private func fetchDetail(movieId: Int) -> AnyPublisher<DetailResponse?, Never> {
        let request = apiRequest.createDetail(movieId: movieId)
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<DetailResponse?> in
                print("Error fetching detail: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchVideo(movieId: Int) -> AnyPublisher<VideoResponse?, Never> {
        let request = apiRequest.createVideo(movieId: movieId)
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<VideoResponse?> in
                print("Error fetching video: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchImages(movieId: Int) -> AnyPublisher<ImagesResponse?, Never> {
        let request = apiRequest.createImages(movieId: movieId)
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<ImagesResponse?> in
                print("Error fetching images: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchSimilar(movieId: Int) -> AnyPublisher<SimilarResponse?, Never> {
        let request = apiRequest.createSimilar(movieId: movieId)
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<SimilarResponse?> in
                print("Error fetching similar: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMovieData(movieId: Int) {
        isLoading = true
        
        Publishers.CombineLatest4(
            fetchDetail(movieId: movieId),
            fetchVideo(movieId: movieId),
            fetchImages(movieId: movieId),
            fetchSimilar(movieId: movieId)
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] _ in
            self?.isLoading = false
        }, receiveValue: { [weak self] (detailResponse, videoResponse, imagesResponse, similarResponse)  in
            self?.detail = detailResponse
            self?.video = videoResponse?.results.first(where: { $0.name == "Official Trailer"})
            self?.posters = imagesResponse?.posters
            self?.similar = similarResponse
        })
        .store(in: &cancellables)
    }
}
