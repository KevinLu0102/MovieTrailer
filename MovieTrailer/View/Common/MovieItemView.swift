//
//  MovieItemView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/11.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieItemView: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .center) {
            if let backdropURL = movie.backdropURL {
                WebImage(url: backdropURL) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.white)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .frame(width: 120, height: 80, alignment: .center)
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)

                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(3)
            }
        }
    }
}
#Preview {
    MovieItemView(movie: Movie(
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
