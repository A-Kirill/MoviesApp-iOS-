//
//  ImageResponse.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 14.02.2022.
//

import Foundation

struct ImageResponse: Codable {
    let images: [MovieImage]
    
    enum CodingKeys: String, CodingKey {
        case images = "items"
    }
}

// MARK: - MovieImage
struct MovieImage: Codable, Identifiable {
    let id = UUID()
    let imageURL: String
    let previewURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case previewURL = "previewUrl"
    }
}
