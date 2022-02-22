//
//  MovieStore.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 16.02.2022.
//

import SwiftUI

class MovieStore: ObservableObject {
    @Published var movies: [Movie] = []
    
    private let fileName = "Movies"
    private let folderName = "MoviesFolder"
    
    init() {
        checkDirectory()
        loadMovies()
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        movies.contains{ $0.kinopoiskID == movie.kinopoiskID }
    }
    
    func addMovie(_ movie: Movie) {
        movies.append(movie)
        save()
    }

    func index(for movie: Movie) -> Int? {
      movies.firstIndex{ $0.kinopoiskID == movie.kinopoiskID }
    }

    func remove(_ movie: Movie) {
      if let index = index(for: movie) {
        movies.remove(at: index)
        save()
      }
    }
    
    func save() {
      do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(movies)
        if let url = FileManager.documentURL?
            .appendingPathComponent(folderName)
            .appendingPathComponent(fileName) {
          try data.write(to: url)
        }
    } catch {
        print(error.localizedDescription)
      }
    }
    
    func checkDirectory() {
        let manager = FileManager.default
        guard let url = FileManager.documentURL else { return }
        let movieFolderUrl = url.appendingPathComponent(folderName)
        do {
            try manager.createDirectory(at: movieFolderUrl,
                                    withIntermediateDirectories: true,
                                    attributes: [:])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadMovies() {
        guard let url = FileManager.documentURL?
                .appendingPathComponent(folderName)
                .appendingPathComponent(fileName) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedMovies = try decoder.decode(Array<Movie>.self, from: data)
            movies = decodedMovies
        } catch {
            print("Error: ", error.localizedDescription)
        }
    }


}
