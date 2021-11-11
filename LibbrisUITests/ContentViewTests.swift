//
//  ContentViewTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-10.
//

import XCTest
@testable import Libbris
class ContentViewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testContentView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        let imageBG = app.images["wall"]
        XCTAssert(imageBG.exists)
        let imageLibbris = app.images["logo_libbris_white"]
        XCTAssert(imageLibbris.exists)
    }
    func testSwitchViewInTabBar() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 3))
        app.buttons["skipButton"].tap()
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(app.buttons["icon_home_nor_iOS_25@1"].waitForExistence(timeout: 4))
        tabBar.buttons["icon_home_nor_iOS_25@1"].tap()
        XCTAssertTrue(tabBar.buttons["icon_home_sel_iOS_25@1"].exists)
        XCTAssertTrue(app.buttons["LibraryBook0"].waitForExistence(timeout: 5))
        tabBar.buttons["icon_settings_nor_iOS_25@1"].tap()
        XCTAssertTrue(tabBar.buttons["icon_settings_sel_iOS_25@1"].exists)
        tabBar.buttons["icon_home_20210913_nor@25"].tap()
        XCTAssertTrue(tabBar.buttons["icon_home_20210913_sel@25"].exists)
    }
}
