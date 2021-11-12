//
//  ConfigPageTests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class ConfigPageTests: XCTestCase {
    // go to every view in configPage
    // switch language and go to other view to
    // show different content
    func testConfigPage() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 1))
        app.buttons["skipButton"].tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        let languageButton = app.buttons["languageSetting"]
        let infoButton = app.buttons["AppInfo"]
        XCTAssertTrue(languageButton.exists)
        XCTAssertTrue(infoButton.exists)
    }
    func testConfigurationPage() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 1))
        app.buttons["skipButton"].tap()
        XCUIApplication().tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"].tap()
        let languageButton = app.buttons["languageSetting"]
        XCTAssert(languageButton.exists)
    }
    func testInfoPage() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 1))
        app.buttons["skipButton"].tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        let infoButton = app.buttons["AppInfo"]
        XCTAssertTrue(infoButton.exists)
        infoButton.tap()
        let textsInfo = app.staticTexts["teamInfo"]
        XCTAssertTrue(textsInfo.exists)
        let icon = app.images["iconImage"]
        XCTAssertTrue(icon.exists)
    }
    func testBlank() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 1))
        app.buttons["skipButton"].tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        settingButton.tap()
        app.staticTexts["privacyBtn"].tap()
        app.buttons["Back"].tap()
    }
    func testLanguage() throws {
        
    }
}
