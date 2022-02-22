//
//  FavoriteView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 17.02.2022.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var store: MovieStore
    @State var editMode = false
    let storeForTest = [movieExampl1, movieExampl2]
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(store.movies) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie)){
                                HStack {
                                    MovieView(movie: movie)
                                    if editMode {
                                        Button {
                                            withAnimation {
                                                store.remove(movie)
                                            }
                                        } label: {
                                            Image(systemName: "delete.left.fill")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Favorites", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            editMode.toggle()
                        }
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView().environmentObject(MovieStore())
    }
}
