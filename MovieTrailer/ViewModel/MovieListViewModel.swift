//
//  MovieListViewModel.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    private var currentPage: Int = 1
    
    private let networkService: NetworkProtocol
    private let movieRequest: MovieRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, movieRequest: MovieRequestProtocol) {
        self.networkService = networkService
        self.movieRequest = movieRequest
    }
    
    func fetchUpcomingMovies() {
        isLoading = true
        
        let request = movieRequest.createUpcoming(page: currentPage)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
                
            } receiveValue: { [weak self] (response: UpcomingResponse) in
                self?.movies = response.results
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }
}
