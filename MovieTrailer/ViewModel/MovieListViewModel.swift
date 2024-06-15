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
    var currentPage: Int = 1
    
    private let networkService: NetworkProtocol
    private let apiRequest: APIRequestProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkProtocol, apiRequest: APIRequestProtocol) {
        self.networkService = networkService
        self.apiRequest = apiRequest
        fetchUpcomingMovies()
    }
    
    func fetchUpcomingMovies() {
        isLoading = true
        
        let request = apiRequest.upcoming(page: currentPage)
        networkService.fetch(with: request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
            } receiveValue: { [weak self] (response: UpcomingResponse) in
                self?.movies = response.results
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }
}
