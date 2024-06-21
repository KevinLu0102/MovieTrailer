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
            
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                }
                    
                VStack(alignment: .leading, spacing: 0) {
                    if let popularMovies = viewModel.popularMovies{
                        Text("Popular")
                            .font(.largeTitle)
                            .bold()
                            .padding(.horizontal)
                        
                        PopularView(popularMovies: popularMovies)
                    }
                    
                    if let upcomingMovies = viewModel.upcomingMovies{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Upcoming")
                                .font(.largeTitle)
                                .bold()
                                .padding(.horizontal)
                                
                            UpcomingView(upcomingMovies: upcomingMovies)
                        }

                    }
                }
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
