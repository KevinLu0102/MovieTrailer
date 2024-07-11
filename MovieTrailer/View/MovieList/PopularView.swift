//
//  PopularView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/21.
//

import SwiftUI

struct PopularView: View {
    let popularMovies: [Movie]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .zero) {
                    ForEach(popularMovies.prefix(10)) { movie in
                        NavigationLink {
                            MovieIntroContentView(movieId: movie.id, title: movie.title)
                        } label: {
                            PosterItemView(imageURL: movie.posterURL, title: movie.title)
                                .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    PopularView(popularMovies: PreviewData.movies)
}
