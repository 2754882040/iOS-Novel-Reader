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

    func testExample()throws {
        let testObj = HomePageTopBar()
        XCTAssertEqual(testObj.add(a: 1, b: 2), 3)
    }
    func testDownloadJsonGetData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testObj: DownloadJson =
        DownloadJson(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters")
        // testObj.getData(URLString: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters")
        sleep(3)
        XCTAssertFalse(testObj.jsonData == Data())
    }

    func testDownloadJsonDecodeData() throws {
        let testObj: DownloadJson =
        DownloadJson(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters")
        sleep(3)
        XCTAssertFalse(testObj.jsonData == Data())
        let jsonResponse: [BookChapter] = try testObj.decodeData(data: testObj.jsonData)
        sleep(1)
        XCTAssertEqual(jsonResponse[0].id, 1)
    }
    func testDownloadJsonGetLocalFileDir() throws {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let testDir = documentDirectory!.appendingPathComponent("test")
        let testObj: DownloadJson =
        DownloadJson(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters")
        XCTAssertEqual(testObj.getLocalFileDir(fileName: "test"), testDir)
    }
    func testLocalJsonFileManagerReadData() {
        let  testObj: localJsonFileManager = localJsonFileManager.shared
        testObj.state = LoadState.loading
        testObj.readData()
        XCTAssertEqual(testObj.state, LoadState.success)
    }
    func testLocaljsonFileManagerSortArray() {
        let  testObj: localJsonFileManager = localJsonFileManager.shared
        testObj.bookShelfBook = [BookInfoBriefWithTime]()
        var testElement1: BookInfoBriefWithTime = BookInfoBriefWithTime()
        testElement1.id = 1
        sleep(1)
        var testElement2: BookInfoBriefWithTime = BookInfoBriefWithTime()
        testElement2.id = 2
        testObj.bookShelfBook.append(testElement1)
        testObj.bookShelfBook.append(testElement2)
        testObj.sortArray()
        XCTAssertEqual(testObj.bookShelfBook[0].id, 2)
    }
    func testAPIfunctions() {
        /*
        getBookByCategoryAPI(categoryId: 11, start: 1, size: 9)
        searchAPI(name: "BALA")
        getBookAPI(bookId: 1)
        getChapterContentAPI(bookId: 1, chapterId: 1)
        getAllChaptersAPI(bookId: 1)
        findCategoriesByLanguageAPI(language: "EN")
        getFeaturedBookListAPI(bookCategoryId: 11)
        getFeaturedBookListAPI(featureBookId: 1, bookCategoryId: 11)
        listAllLanguagesAPI()
        rankControllerSearch(rankTypeName: "HOT", categoryId: 1, cycle: "MONTH", size: 9)
         */
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
