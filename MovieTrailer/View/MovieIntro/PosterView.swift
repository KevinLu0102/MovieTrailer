//
//  PosterView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/16.
//

import SwiftUI
import SDWebImageSwiftUI

struct PosterView: View {
    let posters: [Poster]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<posters.count, id: \.self) { index in
                    if let url = posters[index].filePathURL {
                        WebImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle().foregroundColor(.white)
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .frame(width: 150, height: 225, alignment: .center)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    PosterView(posters: [Poster(aspectRatio: 0.667, height: 3000, iso6391: "en",
                                filePath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                                voteAverage: 5.456, voteCount: 11, width: 2000),
                         Poster(aspectRatio: 0.667, height: 3000, iso6391: "en",
                                filePath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                                voteAverage: 5.456, voteCount: 11, width: 2000),
                         Poster(aspectRatio: 0.667, height: 3000, iso6391: "en",
                                filePath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
                                voteAverage: 5.456, voteCount: 11, width: 2000)])
}
