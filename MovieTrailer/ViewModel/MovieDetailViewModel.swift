//
//  MovieDetailViewModel.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var detail: DetailResponse?
    @Published var video: [Video]?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let networkService: NetworkProtocol
    private let apiRequest: APIRequestProtocol
    
    init(networkService: NetworkProtocol, apiRequest: APIRequestProtocol) {
        self.networkService = networkService
        self.apiRequest = apiRequest
    }
    
    func fetchDetail(movieId: Int) {
        isLoading = true
        
        let request = apiRequest.detail(movieId: movieId)
        networkService.fetch(with: request) { [weak self] (result: Result<DetailResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.detail = success
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            }
        }
    }
    
    func fetchVideo(movieId: Int) {
        isLoading = true
        
        let request = apiRequest.video(movieId: movieId)
        networkService.fetch(with: request) { [weak self] (result: Result<VideoResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self?.video = success.results
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            }
        }
    }
}
