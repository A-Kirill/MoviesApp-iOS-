//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Kirill Anisimov on 22.02.2022.
//

// Breakpoin on app.launch -> Step over -> 'po app'


import XCTest
import MoviesApp

class MoviesAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testPressSettingsOnTabBar() throws {
        let app = XCUIApplication()
        app.launch()

        let settingsButton = app.buttons["Настройки"]
        settingsButton.tap()
        
        let appearanceText = app.staticTexts["Интерфейс"]
        
        XCTAssert(appearanceText.exists)
    }
    
    func testChangeTheme() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Настройки"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.segmentedControls.buttons["Dark"]/*[[".cells[\"Тема, Light, Light, Dark, Dark, Automatic, Automatic\"]",".segmentedControls.buttons[\"Dark\"]",".buttons[\"Dark\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssert(app.tables/*@START_MENU_TOKEN@*/.segmentedControls.buttons["Dark"]/*[[".cells[\"Тема, Light, Light, Dark, Dark, Automatic, Automatic\"]",".segmentedControls.buttons[\"Dark\"]",".buttons[\"Dark\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[1]]@END_MENU_TOKEN@*/.isSelected)
        app.tables.segmentedControls.buttons["Light"].tap()
    }
    
    func testPressFavoriteOnTabBar() throws {
        let app = XCUIApplication()
        app.launch()

        let favoriteButton = app.buttons["Избранное"]
        favoriteButton.tap()
        
        let favoriteNavBarTitle = app.staticTexts["Избранное"]
        
        XCTAssertEqual(favoriteNavBarTitle.label, "Избранное")
    }
    
    func testPressCellOnMainContent() throws {
        let app = XCUIApplication()
        app.launch()

        let cellButton = app.buttons["Item Optional(0)"]
        cellButton.tap()
        let detailView = app.staticTexts["detailsView"]

        XCTAssert(detailView.exists)
    }
    
    
    func testShowTrailersButton() throws {
        let app = XCUIApplication()
        app.launch()

        let cellButton = app.buttons["Item Optional(0)"]
        cellButton.tap()

        let detailView = app.staticTexts["detailsView"]
        detailView.swipeUp()

        app.buttons["Показать"].tap()
        detailView.swipeUp()

        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements

        XCTAssert(elementsQuery.webViews["VideoView"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
