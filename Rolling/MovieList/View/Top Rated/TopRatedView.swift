//
//  TopRatedView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/7/11.
//

import SwiftUI
import SDWebImageSwiftUI

struct TopRatedView: View {
    let topRatedMovies: [Movie]
    let rows = [GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20),
                GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: .zero) {
                ForEach(topRatedMovies) { movie in
                    NavigationLink {
                        MovieIntroContentView(movieId: movie.id, title: movie.title)
                    } label: {
                        TopRatedItemView(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    TopRatedView(topRatedMovies: PreviewData.movies)
}
