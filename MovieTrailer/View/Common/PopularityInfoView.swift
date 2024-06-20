//
//  PopularityInfoView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/16.
//

import SwiftUI

struct popularityInfoView: View {
    @Binding var isShowed: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowed = false
                }

            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 500)
                    .overlay(alignment: .leading) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Popularity")
                                    .font(.headline)
                                Text("Popularity is a fairly important metric here on TMDB. It helps us boost search results, adds an incredibly useful sort value for discover, and is also just kind of fun to see items chart up and down. You can think of popularity as being a \"lifetime\" popularity score that is impacted by the attributes below. It's calculated quite differently than trending.")
                                    .font(.subheadline)
                                Text("")
                                Text("Each model builds their popularity value slightly differently. Here are some of the attributes we use for each media type.")
                                    .font(.subheadline)
                                Text("")
                                VStack(alignment: .leading, spacing: 5){
                                    Text("• Number of votes for the day")
                                    Text("• Number of views for the day")
                                    Text("• Number of users who marked it as a \"favourite\" for the day")
                                    Text("• Number of users who added it to their \"watchlist\" for the day")
                                    Text("• Release date")
                                    Text("• Number of total votes")
                                    Text("• Previous days score")
                                }
                                .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    popularityInfoView(isShowed: .constant(true))
}
