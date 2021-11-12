//
//  LibraryPageTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class LibraryPageTests: XCTestCase {
    func testLibraryBook() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        // app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBook1"].exists)
    }
    func testRecommendBook() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        // app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBookRecommend1"].exists)
    }
}
