//
//  MovieDetailView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/12.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel(networkService: NetworkService.shared, apiRequest: APIRequest())
    @State private var showInfoView = false
    let movieId: Int
    let title: String
    
    var body: some View {
        ZStack {
            ScrollView{
                if viewModel.isLoadingDetail || viewModel.isLoadingVideo {
                    ProgressView()
                } else {
                    if let videoID = viewModel.video?.key{
                        YouTubePlayerView(videoID: videoID)
                            .frame(height: 250)
                    }
                    
                    if let overview = viewModel.detail?.overview,
                       let popularity = viewModel.detail?.popularity,
                       let releaseDate = viewModel.detail?.releaseDate,
                       let runtime = viewModel.detail?.runtime {
                        MovieOverviewView(overview: overview, popularity: popularity, releaseDate: releaseDate,
                                          runtime: runtime, showInfoView: $showInfoView)
                    }
                    
                    if let posters = viewModel.posters{
                        VStack(alignment: .leading) {
                            Text("Poster")
                                .font(.title2)
                                .padding(.horizontal)
                            
                            PosterView(posters: posters)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .onAppear {
                viewModel.fetchVideo(movieId: movieId)
                viewModel.fetchDetail(movieId: movieId)
                viewModel.fetchImages(movieId: movieId)
                
            }
            if showInfoView{ popularityInfoView(isShowed: $showInfoView) }
        }
    }
}

#Preview {
    MovieDetailView(movieId: 1022789, title: "Inside Out 2")
}
