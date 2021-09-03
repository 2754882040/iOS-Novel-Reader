//
//  LibbrisTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-07-21.
//

import XCTest
@testable import Libbris

class LibbrisTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownloadJsonGetData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var testObj: DownloadJson = DownloadJson()
        testObj.getData(URLString: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters")
        sleep(3)
        XCTAssertFalse(testObj.jsonData == Data())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
