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
                Section(header: Text("Popular").font(.largeTitle).bold()) {
                    if viewModel.isLoadingPopular {
                        ProgressView()
                    } else if let popularMovies = viewModel.popularMovies {
                        PopularView(popularMovies: popularMovies)
                            .listRowInsets(.init())
                    } else {
                        Text("Data Fetch Failed")
                            .foregroundColor(.gray)
                    }
                }
                .onAppear {
                    viewModel.fetchPopularMovies()
                }
                
                Section(header: Text("Upcoming").font(.largeTitle).bold()) {
                    if viewModel.isLoadingUpcoming {
                        ProgressView()
                    } else if let upcomingMovies = viewModel.upcomingMovies {
                        UpcomingView(upcomingMovies: upcomingMovies)
                    } else {
                        Text("Data Fetch Failed")
                            .foregroundColor(.gray)
                    }
                }
                .onAppear {
                    viewModel.fetchUpcomingMovies()
                }
                
                Section(header: Text("Top Rated").font(.largeTitle).bold()) {
                    if viewModel.isLoadingTopRated {
                        ProgressView()
                    } else if let topRatedMovies = viewModel.topRatedMovies {
                        TopRatedView(topRatedMovies: topRatedMovies)
                            .listRowInsets(.init())
                            .padding(.vertical)
                    } else {
                        Text("Data Fetch Failed")
                            .foregroundColor(.gray)
                    }
                }
                .onAppear {
                    viewModel.fetchTopRatedMovies()
                }
            }
            .headerProminence(.increased)
        }
    }
}


#Preview {
    MovieListContentView()
}
