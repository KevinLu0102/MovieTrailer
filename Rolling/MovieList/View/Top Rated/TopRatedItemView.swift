//
//  TopRatedItemView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/7/15.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct TopRatedItemView: View {
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
                .aspectRatio(3/2, contentMode: .fit)
                .cornerRadius(8)
            }
            
            Text(movie.title)
                .lineLimit(3)
                .font(.headline)
            
            Spacer()
        }
        .frame(width: 280, height: 80)
        .padding(.leading, 20)
    }
}

#Preview {
    TopRatedItemView(movie: PreviewData.movies[0])
}
