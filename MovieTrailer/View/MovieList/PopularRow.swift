//
//  PopularRow.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopularRow: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            if let backdropURL = movie.posterURL {
                WebImage(url: backdropURL) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.white)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .cornerRadius(8)
                .scaledToFit()
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)

            }

            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
        }
    }
}

#Preview {
    PopularRow(movie: Movie(
        id: 1022789,
        adult: false,
        backdropPath: "/uVu2fBc114un7F1GD76RBouWyBP.jpg",
        genreIds: [16, 10751, 18, 12, 35],
        originalLanguage: "en",
        originalTitle: "Inside Out 2",
        overview: "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
        popularity: 1293.16,
        posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
        releaseDate: "2024-06-12",
        title: "Inside Out 2",
        video: false,
        voteAverage: 8.2,
        voteCount: 19
    ))
}
