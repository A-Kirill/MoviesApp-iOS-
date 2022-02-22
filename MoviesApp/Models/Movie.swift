//
//  Movie.swift
//  MoviesApp
//
//  Created by Kirill Anisimov on 09.02.2022.
//

import Foundation

struct APIResponse: Codable {
    var items: [Movie]
}

struct Movie: Codable, Identifiable, Equatable {
    let id = UUID()
    let kinopoiskID: Int
    let nameRu: String?
    let nameOriginal: String?
    let year: Int?
    let posterURL: String
    let posterURLPreview: String
    let genres: [Genre]?
    let countries: [Country]?
    let duration: Int?
    let premiereRu: String?
    
    //Computed properties:
    var getAllGenres: String {
        guard let genres = genres else { return "" }
        return genres.map{ $0.genre }.joined(separator: ", ")
    }
    var getAllCountries: String {
        guard let countries = countries else { return "" }
        return countries.map{ $0.country }.joined(separator: ", ")
    }
    var formatedPremier: String? {
        return premiereRu?.formateDate()
    }
    
    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case nameRu
        case nameOriginal
        case year
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case genres
        case countries
        case duration
        case premiereRu
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.nameRu == rhs.nameRu
    }
}

struct Genre: Codable {
    let genre: String
}


//MARK: - Examples for previews AND tests

let movieExampl1 = Movie(
    kinopoiskID: 1,
    nameRu: "Браво",
    nameOriginal: "Оригинальное браво",
    year: 2015,
    posterURL: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    posterURLPreview: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    genres: [Genre(genre: "комедия")],
    countries: [Country(country: "США, РУС")],
    duration: 120,
    premiereRu: "2022-22-22"
)

let movieExampl2 = Movie(
    kinopoiskID: 2,
    nameRu: "Маска",
    nameOriginal: "Маска ориг",
    year: 2021,
    posterURL: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    posterURLPreview: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    genres: [Genre(genre: "комедия")],
    countries: [Country(country: "США")],
    duration: 84,
    premiereRu: "2022-22-22"
)

let movieExampl3 = Movie(
    kinopoiskID: 3,
    nameRu: "Смешной фильм",
    nameOriginal: "Оригинальное название",
    year: 2022,
    posterURL: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    posterURLPreview: "https://kinopoiskapiunofficial.tech/images/posters/kp/1437499.jpg",
    genres: [Genre(genre: "комедия")],
    countries: [Country(country: "США")],
    duration: 98,
    premiereRu: "2022-22-22"
)





