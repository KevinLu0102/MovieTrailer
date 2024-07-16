//
//  MovieListViewModel.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var popularMovies: [Movie]?
    @Published var upcomingMovies: [Movie]?
    @Published var topRatedMovies: [Movie]?
    @Published var isLoadingPopular: Bool = false
    @Published var isLoadingUpcoming: Bool = false
    @Published var isLoadingTopRated: Bool = false
    
    private let networkService: NetworkProtocol
    private let movieRequest: MovieRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, movieRequest: MovieRequestProtocol) {
        self.networkService = networkService
        self.movieRequest = movieRequest
    }
    
    func fetchPopularMovies() {
        isLoadingPopular = true
        let request = movieRequest.createPopular()
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoadingPopular = false
                if case .failure = completion {
                    self?.popularMovies = nil
                }
            }, receiveValue: { [weak self] (response: PopularResponse) in
                self?.popularMovies = response.results
            })
            .store(in: &cancellables)
    }

    func fetchUpcomingMovies() {
        isLoadingUpcoming = true
        let request = movieRequest.createUpcoming()
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoadingUpcoming = false
                if case .failure = completion {
                    self?.upcomingMovies = nil
                }
            }, receiveValue: { [weak self] (response: UpcomingResponse) in
                self?.upcomingMovies = response.results
            })
            .store(in: &cancellables)
    }

    func fetchTopRatedMovies() {
        isLoadingTopRated = true
        let request = movieRequest.createTopRated()
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoadingTopRated = false
                if case .failure = completion {
                    self?.topRatedMovies = nil
                }
            }, receiveValue: { [weak self] (response: TopRatedResponse) in
                self?.topRatedMovies = response.results
            })
            .store(in: &cancellables)
    }
}
