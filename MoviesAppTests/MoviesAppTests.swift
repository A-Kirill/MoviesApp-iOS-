//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Kirill Anisimov on 21.02.2022.
//

import XCTest
import Combine
@testable import MoviesApp

class MoviesAppTests: XCTestCase {
    
    var viewModel: MoviesViewModel!
    var movieStore: MovieStore!

    
    override func setUp() {
        viewModel = MoviesViewModel()
        movieStore = MovieStore()
    }
    
    override func tearDown() {
    }
    
    
    func testSortByNameAlph() throws {
        // given
        viewModel.response = APIResponse(items: [movieExampl2, movieExampl1, movieExampl3])
        let expected = APIResponse(items: [movieExampl1, movieExampl2, movieExampl3])
        var result = APIResponse(items: [])
        
        // when
        viewModel.sortByNameAlp(true)
        result = viewModel.response
        
        // then
        XCTAssert(
            result.items == expected.items,
            "Sort expected to be \(expected.items) \n\nbut was \(result.items)"
        )
    }
    
    func testSortByNameNotAlph() throws {
        // given
        viewModel.response = APIResponse(items: [movieExampl2, movieExampl1, movieExampl3])
        let expected = APIResponse(items: [movieExampl3, movieExampl2, movieExampl1])
        var result = APIResponse(items: [])
        
        // when
        viewModel.sortByNameAlp(false)
        result = viewModel.response
        
        // then
        XCTAssert(
            result.items == expected.items,
            "Sort expected to be \(expected.items) \n\nbut was \(result.items)"
        )
    }
    
    
    func testCreatingDirectory() {
        // given
        let manager = FileManager.default
        let folderName = "MoviesFolder"
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let neededURL = urls[0].appendingPathComponent(folderName)
        
        // when
        movieStore.checkDirectory()
        
        // then
        let isDirectory = manager.fileExists(atPath: neededURL.relativePath)
        XCTAssertTrue(isDirectory)
    }
    
    func testIsFavoriteMovie() {
        // given
        movieStore.movies = [movieExampl1, movieExampl3]
        let testMovie = movieExampl3
        let expected = true
        var result = false
        
        // when
        result = movieStore.isFavorite(testMovie)
        // then
        XCTAssert(expected == result, "Movie should be favorite -\(expected), but was - \(result)")
    }
    
    func testIndexForMovie() {
        // given
        movieStore.movies = [movieExampl1, movieExampl3]
        let testMovie = movieExampl3
        let expected = 1
        var result: Int?
        
        // when
        result = movieStore.index(for: testMovie)
        
        // then
        XCTAssert(expected == result, "Movie index should be -\(expected), but was another")
    }
    
    func testAddMovieStore() {
        // given
        movieStore.movies = [movieExampl1]
        let testMovie = movieExampl3
        let expected = true
        var existing = false
        
        // when
        movieStore.addMovie(testMovie)
        existing = movieStore.movies.contains(testMovie)
        
        // then
        XCTAssert(expected == existing, "Movie expected in array -\(expected), but was \(existing)")
    }
    
    func testRemoveMovieStore() {
        // given
        movieStore.movies = [movieExampl1, movieExampl3]
        let testMovie = movieExampl3
        let expected = false
        var existing = true
        
        // when
        movieStore.remove(testMovie)
        existing = movieStore.movies.contains(testMovie)
        
        // then
        XCTAssert(expected == existing, "Movie expected in array -\(expected), but was \(existing)")
        movieStore.remove(movieExampl1)
    }
    
    func testLocalizationNameGetter() {
        // given
        let localize = Localization.ru
        let expected = "ru"
        var result = ""
        
        // when
        result = localize.name
        
        // then
        XCTAssert(expected == result, "Localize should be -\(expected), but was \(result)")
    }
    
    func testLocalizationIdGetter() {
        // given
        let localize = Localization.en
        let expected = "en"
        var result = ""
        
        // when
        result = localize.id
        
        // then
        XCTAssert(expected == result, "Localize should be -\(expected), but was \(result)")
    }
    
    func testAllMovieCountries() {
        // given
        let movie = movieExampl1
        let expected = "США, РУС"
        var result = ""
        
        // when
        result = movie.getAllCountries
        
        // then
        XCTAssert(expected == result, "Localize should be -\(expected), but was \(result)")
    }
    
    func testAppearanceGetter() {
        // given
        let appearanceDark = Appearance.dark
        let appearanceLight = Appearance.light
        let expectedDark = "Dark"
        let expectedLight = "Light"
        var resultDark = ""
        var resultLight = ""
        // when
        resultDark = appearanceDark.name
        resultLight = appearanceLight.name
        
        // then
        XCTAssert(expectedDark == resultDark, "Appearance should be -\(expectedDark), but was \(resultDark)")
        XCTAssert(expectedLight == resultLight, "Appearance should be -\(expectedLight), but was \(resultLight)")
    }
    
    func testAppearanceIdGetter() {
        // given
        let appearanceDark = Appearance.dark
        let appearanceLight = Appearance.light
        let expectedDark = 1
        let expectedLight = 0
        var resultDark = 0
        var resultLight = 0
        
        // when
        resultDark = appearanceDark.id
        resultLight = appearanceLight.id
        
        // then
        XCTAssert(expectedDark == resultDark, "Appearance should be -\(expectedDark), but was \(resultDark)")
        XCTAssert(expectedLight == resultLight, "Appearance should be -\(expectedLight), but was \(resultLight)")
    }
    
    
    func testApiServiceURLbyKeyword() {
        // given
        let name = "kino"
        let expected = "https://kinopoiskapiunofficial.tech/api/v2.2/films/?keyword=kino"
        var result = ""
        
        // when
        result = API.EndPoint.movieByKeyword(name).url.description
        
        // then
        XCTAssert(expected == result, "URL should be -\(expected), but was \(result)")
    }
    
    func testApiServiceURLmovieDetails() {
        // given
        let id = 123
        let expected = "https://kinopoiskapiunofficial.tech/api/v2.2/films/123"
        var result = ""
        
        // when
        result = API.EndPoint.movieDetail(id).url.description
        
        // then
        XCTAssert(expected == result, "URL should be -\(expected), but was \(result)")
    }
}
