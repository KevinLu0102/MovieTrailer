//
//  MovieListContentView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import SwiftUI

struct MovieListContentView: View {
    @StateObject private var viewModel = MovieListViewModel(networkService: NetworkService.shared, movieRequest: MovieRequestFactory())
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Section(header: Text("Popular").font(.largeTitle).bold()) {
                    if let popularMovies = viewModel.popularMovies {
                        PopularView(popularMovies: popularMovies)
                            .frame(width: 350, height: 350)
                    }
                }
                .headerProminence(.increased)
                
                Section(header: Text("Upcoming").font(.largeTitle).bold()) {
                    if let upcomingMovies = viewModel.upcomingMovies {
                        UpcomingView(upcomingMovies: upcomingMovies)
                    }
                }
                .headerProminence(.increased)
            }
            .onAppear {
                viewModel.fetchMovieList()
            }
        }
    }
}

#Preview {
    MovieListContentView()
}
