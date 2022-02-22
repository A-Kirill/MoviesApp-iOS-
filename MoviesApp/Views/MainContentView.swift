//
//  MainContentView.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var viewModel: MoviesViewModel
    @State private var runningSearch = false
    @State private var srtAsc = true
    
    var body: some View {
        
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(viewModel.response.items) { movie in
                            NavigationLink(destination:
                                            MovieDetailsView(movie: movie)
                            ) {
                                MovieView(movie: movie)
                            }
                            .accessibilityIdentifier("Item \(String(describing: viewModel.response.items.firstIndex(of: movie)))")
                        }
                    }
                    .padding()
                }
            }
            .overlay(
                Group {
                    if runningSearch {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                            .opacity(0.8)
                    }
                }
            )
            .navigationTitle("MoviesApp")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        withAnimation {
                            viewModel.sortByNameAlp(srtAsc)
                        }
                        srtAsc.toggle()
                    }
                label: {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                }
            }
        }
        .searchable(text: $viewModel.queryString)
        .onChange(of: viewModel.queryString) { newValue in
                        if newValue == "" {
                            viewModel.getMovies()
                        }
                    }
        .onSubmit(of: .search) {
            Task {
                runningSearch = true
                viewModel.getMoviesByKeyword(viewModel.queryString)
                runningSearch = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
            .environmentObject(MoviesViewModel())
    }
}
