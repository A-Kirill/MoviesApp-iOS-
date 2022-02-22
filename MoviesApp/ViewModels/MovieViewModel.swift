//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    
    @Published var response = APIResponse(items: [])
    @Published var videos = VideoResponse(items: [])
    @Published var images = ImageResponse(images: [])
    @Published var details: MovieDetails?
    @Published var queryString = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private let api = API()
    
    init() {
        getMovies()
    }

    
    func getMovies() {
        api.premiers()
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty() }
            .assign(to: \.response, on: self)
            .store(in: &subscriptions)
    }
    
    func getMoviesByKeyword(_ name: String) {
        if !name.isEmpty {
            api.searchByKeyword(name)
                .receive(on: DispatchQueue.main)
                .catch { _ in Empty() }
                .assign(to: \.response, on: self)
                .store(in: &subscriptions)
        }
    }
    
    func getMovieDetailsFor(_ id: Int) {
        api.movieDetailsBy(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { print("getMovieDetailsFor",$0) },
                  receiveValue: { value in
                self.details = value
            })
            .store(in: &subscriptions)
    }
    
    func getMovieVideosFor(_ id: Int) {
        api.getVideosFor(id)
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty() }
            .assign(to: \.videos, on: self)
            .store(in: &subscriptions)
    }
    
    func getImagesFor(_ id: Int) {
        api.getImagesFor(id)
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty() }
            .assign(to: \.images, on: self)
            .store(in: &subscriptions)
    }
    
    func getFullDetails(_ id: Int) {
        getMovieDetailsFor(id)
        getMovieVideosFor(id)
        getImagesFor(id)
    }
    
    func sortByNameAlp(_ alphabetically: Bool) {
        self.response.items.sort {
            guard let name0 = $0.nameRu, let name1 = $1.nameRu else { return false }
            return alphabetically ? (name0 < name1) : (name0 > name1)
        }
    }
}
