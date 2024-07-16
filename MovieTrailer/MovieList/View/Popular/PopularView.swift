//
//  PopularView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/21.
//

import SwiftUI

struct PopularView: View {
    let popularMovies: [Movie]
    
    init(popularMovies: [Movie]) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .lightGray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.1)
        self.popularMovies = popularMovies
    }
    
    var body: some View {
        GeometryReader { geo in
            TabView {
                ForEach(popularMovies) { movie in
                    NavigationLink {
                        MovieIntroContentView(movieId: movie.id, title: movie.title)
                    } label: {
                        VStack() {
                            PosterItemView(imageURL: movie.posterURL, title: movie.title)
                                .frame(width: geo.size.width, height: geo.size.height - 70)
                                .padding(.top, 20)
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .tabViewStyle(.page)
            
        }
        .frame(height: 400)
    }
}

#Preview {
    PopularView(popularMovies: PreviewData.movies)
}
