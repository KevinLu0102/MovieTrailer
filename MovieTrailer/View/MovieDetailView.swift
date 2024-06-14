//
//  MovieDetailView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel(networkService: NetworkService.shared, apiRequest: APIRequest())
    let movieId: Int
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        if let videoID = viewModel.video?.key{
                            VStack(spacing: 0) {
                                YouTubePlayerView(videoID: videoID)
                                    .frame(height: 200)
                            }
                        }
                          
                        Text("Overview")
                            .font(.headline)
                        
                        Text(detail.overview ?? "")
                            .font(.body)
                    }
                    .padding()
                }
                .navigationBarTitle(detail.title)
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
