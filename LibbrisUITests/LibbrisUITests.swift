//
//  LibbrisUITests.swift
//  LibbrisUITests
//
//  Created by 郝育宽 on 2021-07-21.
//

import XCTest

class LibbrisUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContentView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let image_bg = app.images["bg-wall-ios/Default-568h"]
        XCTAssert(image_bg.exists)
        
        let image_libbris = app.navigationBars.images["logo_libbris_white"]
        XCTAssert(image_libbris.exists)
        
        let image_library = app.navigationBars.images["icon_library_nor"]
        XCTAssert(image_library.exists)
        
        let image_setting = app.navigationBars.images["icon_settings_nor"]
        XCTAssert(image_setting.exists)
                                
    }
    
    func testSplashScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        XCUIDevice.shared.press(.home)//let app run in background
        do
        {
            sleep(7)
        }
        app.activate()
        //XCUIApplication().images["bg-wall-ios/Default-568h"].tap()
        do
        {
            sleep(1)
        }
        let image_ss = app.images["screens/Default-568h"]
        XCTAssert(image_ss.exists)
        do
        {
            sleep(2)
        }
        XCTAssert(!image_ss.exists)
    }
    
    func testBookshelfView() throws{
        let app = XCUIApplication()
        app.launch()
        
        // Test OnReading Horizontal ScrollView
        let onreading_elements_query = app.scrollViews.otherElements.containing(.staticText, identifier:"ON READING")
        onreading_elements_query.children(matching: .image).matching(identifier: "label_reading").element(boundBy: 6).swipeLeft()
        onreading_elements_query.children(matching: .image).matching(identifier: "label_hot").element(boundBy: 6).swipeLeft()
        onreading_elements_query.children(matching: .image).matching(identifier: "default_cover").element(boundBy: 2).swipeLeft()
        onreading_elements_query.children(matching: .image).matching(identifier: "blank_book_shadow").element(boundBy: 6).swipeLeft()
        onreading_elements_query.children(matching: .image).matching(identifier:"bookshelf")


                                
        // Test ToRead Vertical ScrollView
        let toread_elements_query = app.scrollViews.otherElements.containing(.staticText, identifier:"TO READ")
        toread_elements_query.children(matching: .image).matching(identifier: "label_reading").firstMatch.swipeUp()
        toread_elements_query.children(matching: .image).matching(identifier: "label_hot").firstMatch.swipeUp()
        toread_elements_query.children(matching: .image).matching(identifier: "default_cover").element(boundBy: 3).swipeUp()
        toread_elements_query.children(matching: .image).matching(identifier: "blank_book_shadow").element(boundBy: 3).swipeUp()
        toread_elements_query.children(matching: .image).matching(identifier:"bookshelf")
        
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
