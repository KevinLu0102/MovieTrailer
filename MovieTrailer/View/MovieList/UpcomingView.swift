//
//  UpcomingView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/21.
//

import SwiftUI

struct UpcomingView: View {
    let upcomingMovies: [Movie]
    
    var body: some View {
        ForEach(upcomingMovies) { movie in
            NavigationLink {
                MovieIntroContentView(movieId: movie.id, title: movie.title)
            } label: {
                MovieItemView(movie: movie)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    UpcomingView(upcomingMovies: PreviewData.movies)
}
