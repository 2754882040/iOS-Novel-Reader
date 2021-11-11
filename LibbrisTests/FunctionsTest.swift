//
//  FunctionsTest.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-10.
//

import XCTest
@testable import Libbris
class FunctionsTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalizedString() throws {
        changeLanguage(language: "en")
        showLanguage()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
