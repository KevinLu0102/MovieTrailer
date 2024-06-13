//
//  MovieDetailView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import SwiftUI
import WebKit

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel(networkService: NetworkService.shared, apiRequest: APIRequest())
    let movieId: Int
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(detail.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(detail.overview ?? "")
                            .font(.body)
                    }
                    .padding()
                }
            }
            
        }
        
        .onAppear {
            viewModel.fetchDetail(movieId: movieId)
            viewModel.fetchVideo(movieId: movieId)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1022789)
}
