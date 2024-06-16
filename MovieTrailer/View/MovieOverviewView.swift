//
//  MovieOverviewView.swift
//  MovieTrailer
//
//  Created by Kevin Lu on 2024/6/16.
//

import SwiftUI

struct MovieOverviewView: View {
    let overview: String
    let popularity: Double
    let releaseDate: String
    let runtime: Int
    @Binding var showInfoView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Overview")
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                Text(overview)
                    .font(.body)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            
            HStack(spacing: 5) {
                VStack(alignment: .center) {
                    Text("\(popularity, specifier: "%.0f")")
                        .font(.footnote)
                    HStack {
                        Text("Popularity")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            showInfoView = true
                        }, label: {
                            Image(systemName: "info.circle")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        })
                    }
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text(releaseDate)
                        .font(.footnote)
                    Text("Release Date")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("\(runtime) mins")
                        .font(.footnote)
                    Text("Runtime")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MovieOverviewView(overview: "This is  overview", popularity: 3000, releaseDate: "yyyy-MM-dd",
                      runtime: 300, showInfoView: .constant(true))
}
