//
//  LibraryMorePageTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class LibraryMorePageTests: XCTestCase {
    func testLoadMoreBook() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.scrollViews.otherElements.buttons["LibraryBook0"].press(forDuration: 1.4)
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
        app.buttons["LongPressMenu"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_20210913_nor@25"].tap()
        sleep(1)
        let frame1 = app.buttons["HomeBookButton77"].frame
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.scrollViews.otherElements.buttons["LibraryBook1"].press(forDuration: 1.4)
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
        app.buttons["LongPressMenu"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_20210913_nor@25"].tap()
        sleep(1)
        let frame2 = app.buttons["HomeBookButton76"].frame
        XCTAssertEqual(frame1.origin.x, frame2.origin.x)
        XCTAssertEqual(frame1.origin.y, frame2.origin.y)
    }
}
