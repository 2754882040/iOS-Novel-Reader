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
        sleep(2)
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let image_bg = app.images["wall"]
        XCTAssert(image_bg.exists)
        
        let image_libbris = app.images["logo_libbris_white"]
        XCTAssert(image_libbris.exists)
        
                                
    }
    
    func testFirstTimeSplashScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        let Image = app.images["ADImage"]
        XCTAssert(Image.exists)
        //wait for 2 sceond, splash screen will disappear
        
    }
    
    func testSplashScreen() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(6)
        XCUIDevice.shared.press(.home)//let app run in background
        sleep(7)
        app.activate()
        sleep(2)
        let Image = app.images["ADImage"]
        XCTAssert(Image.exists)
    }
    
    func testConfigPage() throws {
        
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        let languageButton = app.buttons["languageSetting"]
        let InfoButton = app.buttons["AppInfo"]
        XCTAssertTrue(languageButton.exists)
        XCTAssertTrue(InfoButton.exists)
    }

    
    func testConfigurationPage() throws{
           let app = XCUIApplication()
           app.launch()
           sleep(2)
           XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
           XCUIApplication().tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"].tap()
           let languageButton = app.buttons["languageSetting"]
           XCTAssert(languageButton.exists)
        
    }
    
    func testInfoPage() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        let InfoButton = app.buttons["AppInfo"]
        XCTAssertTrue(InfoButton.exists)
        InfoButton.tap()
        let textsInfo = app.staticTexts["teamInfo"]
        XCTAssertTrue(textsInfo.exists)
        let icon = app.images["iconImage"]
        XCTAssertTrue(icon.exists)
    }
    func testChangeLanguage() throws{
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let settingButton = app.tabBars["Tab Bar"].buttons["icon_settings_nor_iOS_25@1"]
        XCTAssertTrue(settingButton.exists)
        settingButton.tap()
        //UserDefaults.standard.set("zh-Hans", forKey: "language")
        //NotificationCenter.default.post(name: .switchLanguage, object: nil)
        //sleep(1)
        let LanguageButton = app.buttons["languageSetting"]
        LanguageButton.tap()
        /*if(app.pickerWheels["picker"].exists){
            app.pickerWheels["picker"].swipeUp()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["Francais"].exists)
        }*/
        
        if(app.pickerWheels[strChinese1].exists){
            app.pickerWheels[strChinese1].swipeUp()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["Francais"].exists)
        }
        else if(app.pickerWheels["Francais"].exists){
            app.pickerWheels["Francais"].swipeDown()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["English"].exists)
        }
        else if(app.pickerWheels["English"].exists){
            app.pickerWheels["English"].swipeUp()
            sleep(1)
            XCTAssertTrue(app.pickerWheels["Francais"].exists)
        }
       
    }
    func testSearchArea(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["Search"].tap()
        //app.textFields["search area"].tap()
        XCTAssertTrue(app.textFields["search area"].exists)
        
    }
    
    func testLibraryBook(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        //app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBook1"].exists)
    }
    
    func testRecommendBook(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        //app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["LibraryBookRecommend1"].exists)
    }
    
    func testMorePage(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["MorePageButton"].tap()
        sleep(2)
        XCTAssert(app.scrollViews["HotPage"].exists)
        //XCTAssert(app.buttons["MorePageBooks1"].exists)
        app.swipeLeft()
        XCTAssert(app.scrollViews["RecPage"].exists)
        //XCTAssert(app.buttons["MorePageBooks1"].exists)
        app.swipeLeft()
        XCTAssert(app.scrollViews["NewPage"].exists)
        //XCTAssert(app.buttons["MorePageBooks1"].exists)
        app.swipeUp()
        app.swipeUp()
        XCTAssert(app.staticTexts["NoMoreBooksText"].exists)
    }

    func testHomeBook(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        //app.buttons["LibraryBook0"].tap()
        sleep(2)
        XCTAssertTrue(app.buttons["BookButton0"].exists)
    }
}


