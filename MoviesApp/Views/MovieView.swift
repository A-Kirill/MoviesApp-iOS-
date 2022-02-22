//
//  MovieView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: movie.posterURLPreview), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
                       placeholder: {
                ActivityIndicator()
            })
                .cornerRadius(5)
                .frame(width: 60, height: 100)

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(movie.nameRu ?? movie.nameOriginal ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.label))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    if let year = movie.year {
                        Text(String(year))
                            .foregroundColor(.black)
                    }
                }
                
                Text(movie.getAllGenres)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                if let premier = movie.formatedPremier {
                    Text("Since \(premier)")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            Color.white.opacity(0.7)
        )
        .clipShape(
          RoundedRectangle(cornerRadius: 15)
        )
//        .overlay(
//          RoundedRectangle(cornerRadius: 20)
//            .stroke()
//        )
        
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: movieExampl1)
            .environmentObject(MoviesViewModel())
    }
}
