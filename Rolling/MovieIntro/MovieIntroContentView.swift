//
//  MovieIntroContentView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/6/12.
//

import SwiftUI

struct MovieIntroContentView: View {
    @StateObject private var viewModel = MovieIntroViewModel(networkService: NetworkService.shared, movieRequest: MovieRequestFactory(apiConfig: MovieAPIConfig(),
                                                                                                                                      languageRegion: LanguageRegion(option: .system),
                                                                                                                                      requestProducer: RequestProducer()))
    @State private var showInfoView = false
    let movieId: Int
    let title: String
    
    var body: some View {
        ZStack {
            ScrollView{
                if viewModel.isLoading{
                    ProgressView()
                }
                
                if let videoID = viewModel.video?.key{
                    YouTubePlayerView(videoID: videoID)
                        .frame(height: 250)
                    }
                    
                if let overview = viewModel.detail?.overview,
                    let popularity = viewModel.detail?.popularity,
                    let releaseDate = viewModel.detail?.releaseDate,
                    let runtime = viewModel.detail?.runtime {
                    VStack(alignment: .leading) {
                        Text("Overview")
                            .font(.title2)
                            .padding(.horizontal)
                            
                        OverviewView(overview: overview,
                                     popularity: popularity,
                                     releaseDate: releaseDate,
                                     runtime: runtime,
                                     showInfoView: $showInfoView)
                        }
                    }
                    
                    if let posters = viewModel.posters{
                        VStack(alignment: .leading) {
                            Text("Poster")
                                .font(.title2)
                                .padding(.horizontal)
                            
                            PosterView(posters: posters)
                        }
                    }
                    
                    if let similar = viewModel.similar{
                        VStack(alignment: .leading) {
                            Text("Similar")
                                .font(.title2)
                                .padding(.horizontal)
                            
                            SimilarView(similar: similar)
                        }
                    }
                }
                
                if showInfoView{ 
                    popularityInfoView(isShowed: $showInfoView)
                }
            }
            .navigationTitle(title)
            .onAppear {
                viewModel.fetchMovieData(movieId: movieId)
            }
        }
    }

#Preview {
    MovieIntroContentView(movieId: 1022789, title: "Inside Out 2")
}
