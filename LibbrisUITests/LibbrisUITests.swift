//
//  LibbrisUITests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-07-21.
//

import XCTest
@testable import Libbris
import SwiftUI
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
    func testHomeBook() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
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
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        sleep(1)
        app.scrollViews.otherElements.buttons["LibraryBook1"].press(forDuration: 1.4)
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
    func testSearchPage() {
        let app = XCUIApplication()
        app.launch()
        sleep(1)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        sleep(1)
        let typeContent = app.textFields["SearchArea"]
        typeContent.tap()
        typeContent.typeText("Alice")
        app.buttons["SearchButton"].tap()
        XCTAssertTrue(app.scrollViews["SearchResultsPage"].exists)
    }
    func testReadingBookChapters() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        // swiftlint:disable line_length
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews["HomePageScrollView"].otherElements.buttons["HomeBookButton76"].tap()
        let normalized = app.staticTexts["BookContent"].coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate = normalized.withOffset(CGVector(dx: 300, dy: 10)) // RIGHT
        let coordinate2 = normalized.withOffset(CGVector(dx: 150, dy: 10)) // MID
        let coordinate3 = normalized.withOffset(CGVector(dx: 0, dy: 10))  // LEFT
        coordinate3.tap()
        _ = app.alerts["This is the first page"].scrollViews.otherElements.buttons["OK"]
        app.staticTexts["BookContent"].swipeLeft()
        app.staticTexts["BookContent"].swipeRight()
        coordinate2.tap()
        app.alerts["Want to exist?"].scrollViews.otherElements.buttons["Exist"].tap()
        app.scrollViews["HomePageScrollView"].otherElements.buttons["HomeBookButton76"].tap()
        for _ in 0 ..< 13 {
            coordinate.tap()
        }
        let scrollViewsQuery = app.alerts["This is the last page"].scrollViews
        let thisIsTheLastPageElement = scrollViewsQuery.otherElements.containing(.staticText, identifier: "This is the last page").element
        thisIsTheLastPageElement.tap()
        thisIsTheLastPageElement.tap()
        scrollViewsQuery.otherElements.buttons["OK"].tap()
        // swiftlint:enable line_length
    }
    func testDispalyCatalog() {
        let app = XCUIApplication()
        app.launch()
        sleep(1)
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        sleep(1)
        app.buttons["LibraryBook0"].press(forDuration: 1.4)
        XCTAssertTrue(app.buttons["CatalogButton"].exists)
        app.buttons["CatalogButton"].tap()
        sleep(1)
        XCTAssertTrue(app.staticTexts["ChapterButton0"].exists)
    }
    func testReadingBotBar() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.buttons["skipButton"].waitForExistence(timeout: 5))
        app.buttons["skipButton"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["LibraryBook0"].tap()
        XCTAssertFalse(app.buttons["fontSmall"].exists)
        let normalized = app.staticTexts["BookContent"].coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let coordinate2 = normalized.withOffset(CGVector(dx: 150, dy: 10)) // MID
        coordinate2.tap()
        XCTAssertTrue(app.buttons["fontSmall"].exists)
        app.buttons["fontSmall"].tap()
        app.buttons["fontMid"].tap()
        app.buttons["fontLarge"].tap()
        app.buttons["color1"].tap()
        app.buttons["color2"].tap()
        app.buttons["color3"].tap()
        app.buttons["nightModeController"].tap()
    }
}
