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
        ScrollView{
            if viewModel.isLoadingDetail || viewModel.isLoadingVideo {
                ProgressView()
            } else {
                if let videoID = viewModel.video?.key{
                    YouTubePlayerView(videoID: videoID)
                        .frame(height: 250)
                }
                
                if let overview = viewModel.detail?.overview{
                    VStack(alignment: .leading){
                        Text("Overview")
                            .font(.headline)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        
                        Text(overview)
                            .font(.body)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    }
                }
            }
            
        }
        .onAppear {
            viewModel.fetchVideo(movieId: movieId)
            viewModel.fetchDetail(movieId: movieId)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1022789)
}
