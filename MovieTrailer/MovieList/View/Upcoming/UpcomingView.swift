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
            UpcomingItemView(movie: movie)
                .background(
                    NavigationLink("", destination: MovieIntroContentView(movieId: movie.id, title: movie.title))
                        .opacity(0)
                )
        }
    }
}

#Preview {
    UpcomingView(upcomingMovies: PreviewData.movies)
}
