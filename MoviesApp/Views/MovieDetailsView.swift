//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 14.02.2022.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    @EnvironmentObject var store: MovieStore
    @State var movie: Movie
    @State var videoURL: String?
    @State var videoPlayerHidden = true
    
    var body: some View {
        
        ZStack {
            BackgroundView()
            ScrollView {
                VStack {
                    HStack {
                        AsyncImage(url: URL(string: movie.posterURL)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ActivityIndicator()
                        }
                        .frame(maxWidth: 150)
                        .cornerRadius(15)
                        .shadow(color: .white, radius: 5)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(movie.nameRu ?? movie.nameOriginal ?? "")
                                    .font(.headline)
                                .fontWeight(.bold)
                                
                                Spacer()
                                
                                Button {
                                    store.isFavorite(movie) ?
                                    store.remove(movie) :
                                    store.addMovie(movie)
                                } label: {
                                    store.isFavorite(movie) ?
                                    Image(systemName: "bookmark.fill").foregroundColor(Color("TabBarSelected")) :
                                    Image(systemName: "bookmark").foregroundColor(.black)
                                }
                            }
                            HStack {
                                if let year = movie.year {
                                    Text(String(year))
                                }
                                Spacer()
                                
                                Text(String(viewModel.details?.ratingKinopoisk ?? 0))
                                    .padding(.horizontal, 5)
                                    .background(
                                        Color.white.opacity(0.7)
                                    )
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 5)
                                    )
                                    
                            }
                            Text(movie.getAllGenres)
                            Text(movie.getAllCountries)
                        }
                    }
                
                    Divider().background(.white)
                    
                    Text(viewModel.details?.description ?? "No descrition")
                        .multilineTextAlignment(.leading)
                        .accessibilityIdentifier("detailsView")
                    
//MARK: - Images
                    Divider()
                        .background(.white)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.images.images) { image in
                                AsyncImage(url: URL(string: image.previewURL)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(15)
                                    } else if phase.error != nil {
                                        EmptyView()
                                    } else {
                                        ActivityIndicator()
                                    }
                                }
                            }
                        }
                    }
                    
//MARK: - Video
                    Divider()
                        .background(.white)
                    HStack {
                        Text("Trailers:")
                        Spacer()
                        Button {
                            videoPlayerHidden.toggle()
                        } label: {
                            videoPlayerHidden ? Text("Show") : Text("Hide")
                        }
                        .foregroundColor(.gray)
                    }
                    

                    if !videoPlayerHidden {
                        VideoView(url: videoURL == nil
                                  ? viewModel.videos.items.first?.url ?? "" : videoURL!)
                            .aspectRatio(16/9, contentMode: .fill)
                            .foregroundColor(.blue)
                            .cornerRadius(15)
                        VStack{
                            ForEach(viewModel.videos.supported) { item in
                                Button {
                                    videoURL = item.url
                                } label: {
                                    Text(item.name)
                                }
                            }
                        }
                    }
                    Divider()
                        .background(.white)
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getFullDetails(movie.kinopoiskID)
        }
    }
}

struct MovieDetatilView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: movieExampl1)
            .environmentObject(MoviesViewModel())
            .environmentObject(MovieStore())
    }
}
