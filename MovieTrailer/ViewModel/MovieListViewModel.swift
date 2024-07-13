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
    @Published var isLoading: Bool = false
    
    private let networkService: NetworkProtocol
    private let movieRequest: MovieRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, movieRequest: MovieRequestProtocol) {
        self.networkService = networkService
        self.movieRequest = movieRequest
    }
    
    private func fetchUpcomingMovies() -> AnyPublisher<UpcomingResponse?, Never> {
        let request = movieRequest.createUpcoming()
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<UpcomingResponse?> in
                print("Error fetching upcoming: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchPopularMovies() -> AnyPublisher<PopularResponse?, Never>{
        let request = movieRequest.createPopular()
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<PopularResponse?> in
                print("Error fetching popular: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchTopRatedMovies() -> AnyPublisher<TopRatedResponse?, Never> {
        let request = movieRequest.createTopRated()
        return networkService.fetch(with: request)
            .map { $0 }
            .catch { error -> Just<TopRatedResponse?> in
                print("Error fetching top rated: \(error.localizedDescription)")
                return Just(nil)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMovieList() {
        isLoading = true
        
        Publishers.CombineLatest3(
            fetchPopularMovies(),
            fetchUpcomingMovies(),
            fetchTopRatedMovies()
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] _ in
            self?.isLoading = false
        }, receiveValue: { [weak self] (popularResponse, upcomingResponse, topRatedResponse)  in
            self?.popularMovies = popularResponse?.results
            self?.upcomingMovies = upcomingResponse?.results
            self?.topRatedMovies = topRatedResponse?.results
        })
        .store(in: &cancellables)
    }
}
