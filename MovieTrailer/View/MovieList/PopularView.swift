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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(popularMovies.prefix(10)) { movie in
                    NavigationLink {
                        MovieIntroContentView(movieId: movie.id, title: movie.title)
                    } label: {
                        PosterItemView(imageURL: movie.posterURL, title: movie.title)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.vertical)
        .scrollTargetBehavior(.paging)
    }
}

#Preview {
    PopularView(popularMovies: PreviewData.movies)
}
