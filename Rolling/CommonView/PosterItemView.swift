//
//  PosterItemView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/6/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct PosterItemView: View {
    let imageURL: URL?
    let title: String?
    
    var body: some View {
        VStack(alignment: .center) {
            if let imageURL = imageURL {
                WebImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle().foregroundColor(.white)
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .cornerRadius(8)
                .scaledToFit()
                .shadow(color: .black.opacity(0.3), radius: 5, x: 10, y: 10)
            }
            
            if let title{
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
            }
 
        }
    }
}

#Preview {
    PosterItemView(imageURL: URL(string: "https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg"), title: "Inside Out 2")
}
