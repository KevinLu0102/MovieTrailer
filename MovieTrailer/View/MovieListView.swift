//
//  ContentView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel(networkService: NetworkService.shared, apiRequest: APIRequest())

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            }else if let movies = viewModel.movies {
                List(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.id, title: movie.title)) {
                        MovieRow(movie: movie)
                    }
                }
                .navigationBarTitle("Upcoming")
            }
        }
    }
}

#Preview {
    MovieListView()
}
