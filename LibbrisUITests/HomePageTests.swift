//
//  HomePageTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class HomePageTests: XCTestCase {
    // scenario1: add one book
    // scenario2: add two books(will sort by time)
    func testAddBook() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.buttons["icon_settings_nor_iOS_25@1"].tap()
        app.buttons["clearData"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["LibraryBookRecommend0"].press(forDuration: 1.1)
        app.buttons["LongPressMenu"].tap()
        app.buttons["LibraryBookRecommend2"].press(forDuration: 1.1)
        app.buttons["LongPressMenu"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_20210913_nor@25"].tap()
        XCTAssertTrue(app.buttons["HomeBookButton77"].exists)
        XCTAssertTrue(app.buttons["HomeBookButton75"].exists)
    }
}
