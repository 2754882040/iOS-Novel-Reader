//
//  LibbrisUITests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-07-21.
//

import XCTest
extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        self.typeText(text)
    }
}

class LibbrisUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        /* In UI tests it’s important to set the initial state - such as interface orientation
         - required for your tests before they run. The setUp method is a good place to do this.*/
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContentView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        let imageBG = app.images["wall"]
        XCTAssert(imageBG.exists)
        let imageLibbris = app.images["logo_libbris_white"]
        XCTAssert(imageLibbris.exists)
    }
    func testFirstTimeSplashScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let imageAD = app.images["ADImage"]
        XCTAssert(imageAD.exists)
        // wait for 2 sceond, splash screen will disappear
    }
    func testSplashScreen() throws {
        // UI tests must launch the application that they test.
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
    func testConfigPage() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
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
        sleep(2)
        app.buttons["skipButton"].tap()
        XCUIApplication().tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"].tap()
        let languageButton = app.buttons["languageSetting"]
        XCTAssert(languageButton.exists)
    }
    func testInfoPage() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
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
    func testChangeLanguage() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        let languageButton = app.buttons["languageSetting"]
        languageButton.tap()
        if app.pickerWheels[strChinese1].exists {
            app.pickerWheels[strChinese1].swipeUp()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["Francais"].exists)
        } else if app.pickerWheels["Francais"].exists {
            app.pickerWheels["Francais"].swipeDown()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["English"].exists)
        } else if app.pickerWheels["English"].exists {
            app.pickerWheels["English"].swipeUp()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["Francais"].exists)
        }
        app.buttons["LanguagePageBack"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["Search"].tap()
        app.buttons["LIBRARY"].tap()
        app.buttons["MorePageButton"].tap()
    }
    func testSearchArea() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["Search"].tap()
        // app.textFields["search area"].tap()
        XCTAssertTrue(app.textFields["search area"].exists)
    }
    func testLibraryBook() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        // app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBook1"].exists)
    }
    func testRecommendBook() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        // app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBookRecommend1"].exists)
    }
    func testMorePage() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["MorePageButton"].tap()
        sleep(2)
        XCTAssert(app.scrollViews["HotPage"].exists)
        app.swipeUp(velocity: 10000)
        XCTAssert(app.staticTexts["textLoading"].exists)
        app.swipeUp(velocity: 1000)
        app.swipeUp(velocity: 1000)
        XCTAssert(app.staticTexts["textNoMoreBooks"].exists)
        app.swipeLeft()
        XCTAssert(app.scrollViews["RecPage"].exists)
        app.swipeLeft()
        XCTAssert(app.scrollViews["NewPage"].exists)
        app.staticTexts["RECOMMEND"].tap()
        app.staticTexts["NEW"].tap()
        app.staticTexts["HOT"].tap()
    }

    func testHomeBook() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        // app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        // app.buttons["LibraryBook0"].tap()
        sleep(2)
        // XCTAssertTrue(app.buttons["BookButton77"].exists)
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["MorePageButton"].tap()
        sleep(2)
        app.buttons["LibraryBook1"].press(forDuration: 1)
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
    }
    func testLoadMoreBook() {
        let app = XCUIApplication()
        app.launch()
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

    func testBookDetailView() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["LibraryBook0"].tap()
        sleep(1)
        app.buttons["NEXT PAGE"].tap()
        sleep(1)
        app.buttons["PREVIOUS PAGE"].tap()
        sleep(1)
        app.buttons["back"].tap()
        XCTAssertTrue(app.staticTexts["BookContent"].exists)
    }
    func testSearchBackgroundText() {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        let input = "Caseyp"
        let empty = "search area"
        XCTAssertTrue(app.textFields["SearchField"].exists)
        app.textFields["SearchField"].tap()
        app.textFields["SearchField"].typeText("Caseyp")
        XCTAssertEqual(app.textFields["SearchField"].value as? String, input)
        app.textFields["SearchField"].tap()
        app.textFields["SearchField"].clearAndEnterText(text: "")
        XCTAssertEqual(app.textFields["SearchField"].value as? String, empty)
    }
}
