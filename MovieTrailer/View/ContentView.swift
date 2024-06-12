//
//  ContentView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel(networkService: NetworkService.shared, apiRequest: APIRequest())

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                List(viewModel.movies) { movie in
                    MovieRow(movie: movie)
                }
                .navigationBarTitle("Upcoming")
            }
        }
    }
}

#Preview {
    ContentView()
}
