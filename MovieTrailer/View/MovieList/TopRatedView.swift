//
//  TopRatedView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/7/11.
//

import SwiftUI

struct TopRatedView: View {
    let topRatedMovies: [Movie]
    
    var body: some View {
        ForEach(topRatedMovies) { movie in
            NavigationLink {
                MovieIntroContentView(movieId: movie.id, title: movie.title)
            } label: {
                MovieItemView(movie: movie)
            }
            .buttonStyle(.plain)
        }
    }
}
