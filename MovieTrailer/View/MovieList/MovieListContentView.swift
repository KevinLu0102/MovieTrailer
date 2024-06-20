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
                            
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(popularMovies.prefix(10)) { movie in
                                    NavigationLink {
                                        MovieIntroContentView(movieId: movie.id, title: movie.title)
                                    } label: {
                                        PopularRow(movie: movie)
                                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.vertical)
                        .scrollTargetBehavior(.paging)
                    }
                    
                    if let upcomingMovies = viewModel.upcomingMovies{
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Upcoming")
                                .font(.largeTitle)
                                .bold()
                                .padding(.horizontal)
                                
                            ForEach(upcomingMovies) { movie in
                                NavigationLink {
                                    MovieIntroContentView(movieId: movie.id, title: movie.title)
                                } label: {
                                    MovieRow(movie: movie)
                                }
                                .buttonStyle(.plain)
                                .padding()
                                    
                                Divider()
                                    .padding(.horizontal, 10)
                            }
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
