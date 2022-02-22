//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 10.02.2022.
//

import Foundation

struct MovieDetails: Codable{
    let kinopoiskID: Int
    let imdbID: String?
    let nameRu: String?
    let nameEn: String?
    let posterURL: String?
    let posterURLPreview: String?
    let ratingKinopoisk: Double?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let type: String?
    let countries: [Country]?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case imdbID = "imdbId"
        case nameRu
        case nameEn
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case ratingKinopoisk
        case year
        case description
        case shortDescription
        case type
        case countries
        case genres
    }
}

// MARK: - Country
struct Country: Codable {
    let country: String
}

//extension MovieDetails, Equatable  {
//    static func == (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
//        return lhs.kinopoiskID == rhs.kinopoiskID
//    }
//}
