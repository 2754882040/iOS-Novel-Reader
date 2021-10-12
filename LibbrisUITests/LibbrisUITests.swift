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
        let LanguageButton = app.buttons["languageSetting"]
        LanguageButton.tap()
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
        app.buttons["LanguagePageBack"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["Search"].tap()
        app.buttons["LIBRARY"].tap()
        app.buttons["MorePageButton"].tap()
                       
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

    func testHomeBook(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        //app.buttons["LibraryBook0"].tap()
        sleep(2)
        //XCTAssertTrue(app.buttons["BookButton77"].exists)
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["MorePageButton"].tap()
        sleep(2)
        app.buttons["LibraryBook1"].press(forDuration: 1)
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
    }
    
    func testLoadMoreBook(){
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["LibraryBook0"].press(forDuration: 1.4);/*[[".buttons[\"The Black Cat, \\\"The Black Cat\\\" is a short story by Edgar Allan Poe. It was first published in the August 19, 1843, edition of The Saturday Evening Post. It is a study of the psychology of guilt, often paired in analysis with Poe's \\\"The Tell-Tale Heart\\\". In both, a murderer carefully conceals his crime and believes himself unassailable, but eventually breaks down and reveals himself, impelled by a nagging reminder of his guilt., Edgar Allan Poe\"]",".tap()",".press(forDuration: 1.4);",".buttons[\"LibraryBook0\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
        app.buttons["LongPressMenu"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_20210913_nor@25"].tap()
        sleep(1)
        let frame1 = app.buttons["HomeBookButton77"].frame
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.scrollViews.otherElements.buttons["LibraryBook1"].press(forDuration: 1.4);
        XCTAssertTrue(app.buttons["LongPressMenu"].exists)
        app.buttons["LongPressMenu"].tap()
        app.tabBars["Tab Bar"].buttons["icon_home_20210913_nor@25"].tap()
        sleep(1)
        let frame2 = app.buttons["HomeBookButton76"].frame
        XCTAssertEqual(frame1.origin.x, frame2.origin.x)
        XCTAssertEqual(frame1.origin.y, frame2.origin.y)
    }

    func testBookDetailView(){
        let app = XCUIApplication()
        app.launch()
        sleep(2)
        app/*@START_MENU_TOKEN@*/.buttons["skipButton"]/*[[".buttons[\"Skip\"]",".buttons[\"skipButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars["Tab Bar"].buttons["icon_home_nor_iOS_25@1"].tap()
        app.buttons["LibraryBook0"].tap()
        sleep(1)
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["BookContent"]/*[[".staticTexts[\"<p>Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, &#39;and what is the use of a book,&#39; thought Alice &#39;without pictures or conversations?&#39;<\/p><p>So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.<\/p><p>There was nothing so&nbsp;<em>very<\/em>&nbsp;remarkable in that; nor did Alice think it so&nbsp;<em>very<\/em>&nbsp;much out of the way to hear the Rabbit say to itself, &#39;Oh dear! Oh dear! I shall be late!&#39; (when she thought it over afterwards, it occurred to her that she ought to have wondered at this, but at the time it all seemed quite natural); but when the Rabbit actually&nbsp;<em>took a watch out of its waistcoat-pocket<\/em>, and looked at it, and then hurried on, Alice started to her feet, for it flashed across her mind that she had never before seen a rabbit with either a waistcoat-pocket, or a watch to take out of it, and burning with curiosity, she ran across the field after it, and fortunately was just in time to see it pop down a large rabbit-hole under the hedge.<\/p><p>In another moment down went Alice after it, never once considering how in the world she was to get out again.<\/p><p>The rabbit-hole went straight on like a tunnel for some way, and then dipped suddenly down, so suddenly that Alice had not a moment to think about stopping herself before she found herself falling down a very deep well.<\/p><p>Either the well was very deep, or she fell very slowly, for she had plenty of time as she went down to look about her and to wonder what was going to happen next. First, she tried to look down and make out what she was coming to, but it was too dark to see anything; then she looked at the sides of the well, and noticed that they were filled with cupboards and book-\"]",".staticTexts[\"BookContent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }
}
