//
//  SimilarView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/17.
//

import SwiftUI
import SDWebImageSwiftUI

struct SimilarView: View {
    let similar: SimilarResponse
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(similar.results) { movie in
                    ZStack() {
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(.white)
                                .frame(width: geometry.size.width  ,
                                       height: geometry.size.height ,
                                       alignment: .center)
                        }
                        
                        VStack(alignment: .leading) {
                            WebImage(url: movie.posterURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding([.top, .leading, .trailing], 5)
                            
                            Text(movie.title)
                                .font(.system(size: 12))
                                .lineLimit(2)
                                .bold()
                                .padding(.all, 5)
                        }
                    }
                }
            }
            .padding()
            .background(.black)
        }
    }
}

#Preview {
    SimilarView(similar: SimilarResponse(page: 0, results: [
        Movie(
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
    ), Movie(
        id: 1022788,
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
    ),Movie(
        id: 1022787,
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
    )],totalPages: 0, totalResults: 0))
}
