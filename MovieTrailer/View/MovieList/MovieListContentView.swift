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
                            .listRowInsets(.init())
                    }
                }
                
                Section(header: Text("Upcoming").font(.largeTitle).bold()) {
                    if let upcomingMovies = viewModel.upcomingMovies {
                        UpcomingView(upcomingMovies: upcomingMovies)
                    }
                }
                
                Section(header: Text("Top Rated").font(.largeTitle).bold()) {
                    if let topRatedMovies = viewModel.topRatedMovies {
                        TopRatedView(topRatedMovies: topRatedMovies )
                            .listRowInsets(.init())
                            .padding(.vertical)
                    }
                }
            }
            .headerProminence(.increased)
            .onAppear {
                viewModel.fetchMovieList()
            }
        }
    }
}

#Preview {
    MovieListContentView()
}
