//
//  SplashScreenTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class SplashScreenTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDismissWithoutPressBtn() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["icon_home_nor_iOS_25@1"].waitForExistence(timeout: 4))
    }
    func testDismissWithPressBtn() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 3))
        app.buttons["skipButton"].tap()
        XCTAssertTrue(app.buttons["icon_home_nor_iOS_25@1"].waitForExistence(timeout: 4))
    }
    // scenario1: no image avaliable
    // scenario2: image avaliable
    func testFirstTimeSplashScreenNoImageAvaliable() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 1))
        let imageAD = app.images["ADImage"]
        XCTAssert(imageAD.exists)
    }
    func testSplashScreen() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(6)
        XCUIDevice.shared.press(.home)// let app run in background
        sleep(7)
        app.activate()
        sleep(2)
        let imageAD = app.images["ADImage"]
        XCTAssert(imageAD.exists)
    }

}
