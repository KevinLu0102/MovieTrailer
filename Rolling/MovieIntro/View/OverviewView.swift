//
//  OverviewView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/6/16.
//

import SwiftUI

struct OverviewView: View {
    let overview: String
    let popularity: Double
    let releaseDate: String
    let runtime: Int
    @Binding var showInfoView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(overview)
                .font(.footnote)
                .padding(.horizontal)
            
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
    OverviewView(overview: "This is  overview", popularity: 3000, releaseDate: "yyyy-MM-dd",
                      runtime: 300, showInfoView: .constant(true))
}
