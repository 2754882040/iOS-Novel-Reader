//
//  bookInfoInitTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-10.
//

import XCTest
@testable import Libbris
class BookInfoInitTests: XCTestCase {
    func testBookInfoBriefInit() throws {
        let testObj = BookInfoBrief()
        XCTAssertEqual(testObj.id, 0)
    }
    func testBookChapterInit() throws {
        let testObj = BookChapter()
        XCTAssertEqual(testObj.id, 0)
    }
    func testBookInfoBriefWithTimeInit() throws {
        let testObj = BookInfoBriefWithTime()
        XCTAssertEqual(testObj.id, 0)
        sleep(1)
        let testObj2 = BookInfoBriefWithTime()
        XCTAssertTrue(testObj2 < testObj)
        XCTAssertFalse(testObj < testObj2)
        var temp = BookInfoBrief()
        temp.id = 8
        let testObj3 = BookInfoBriefWithTime(book: temp)
        XCTAssertEqual(testObj3.id, 8)
    }
}
