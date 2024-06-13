//
//  MovieListViewModel.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import Foundation
import SwiftUI

class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    var currentPage: Int = 1
    
    private let networkService: NetworkProtocol
    private let apiRequest: APIRequestProtocol
    
    init(networkService: NetworkProtocol, apiRequest: APIRequestProtocol) {
        self.networkService = networkService
        self.apiRequest = apiRequest
        fetchUpcomingMovies()
    }
    
    func fetchUpcomingMovies() {
        isLoading = true
        
        let request = apiRequest.upcoming(page: currentPage)
        networkService.fetch(with: request) { [weak self] (result: Result<UpcomingResponse, NetworkError>) in
            DispatchQueue.main.async{
                switch result {
                case .success(let success):
                    self?.movies = success.results
                    self?.currentPage += 1
                case .failure(let error):
                    self?.error = error
                }
                self?.isLoading = false
            }
        }
    }
}
