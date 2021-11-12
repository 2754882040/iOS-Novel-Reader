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
        UserDefaults.standard.removeObject(forKey: "language")
        XCTAssertEqual(localizedString(text: "Skip"), "Skip")
        changeLanguage(languageCode: 3)
        changeLanguage(languageCode: 0)
        showLanguage()
        XCTAssertEqual(localizedString(text: "Skip"), "Skip")
        changeLanguage(languageCode: 1)
        XCTAssertEqual(localizedString(text: "Skip"), "跳过")
        changeLanguage(languageCode: 2)
        XCTAssertEqual(localizedString(text: "Skip"), "Sauter")
    }
    func testGetLanguageNumber() throws {
        changeLanguage(languageCode: 0)
        XCTAssertEqual(getLanguageNumber(), 0)
        UserDefaults.standard.removeObject(forKey: "language")
        XCTAssertEqual(getLanguageNumber(), 0)
        changeLanguage(languageCode: 1)
        XCTAssertEqual(getLanguageNumber(), 1)
        changeLanguage(languageCode: 2)
        XCTAssertEqual(getLanguageNumber(), 2)
    }
    func testAPIfunctions() throws {
        _ = getBookByCategoryAPI(categoryId: 11, start: 1, size: 1)
        _ = searchAPI(name: "bala")
        _ = getBookAPI(bookId: 1)
        _ = getChapterContentAPI(bookId: 1, chapterId: 1)
        _ = getAllChaptersAPI(bookId: 1)
        _ = findCategoriesByLanguageAPI(language: "en")
        _ = getFeaturedBookListAPI(bookCategoryId: 1)
        _ = getFeaturedBookListAPI(featureBookId: 1, bookCategoryId: 1)
        _ = listAllLanguagesAPI()
        _ = rankControllerSearch(rankTypeName: "asd", categoryId: 1, cycle: "month", size: 5)
    }
    func testEncodeData() throws {
        var chapter: [BookChapter] = [BookChapter]()
        chapter.append(BookChapter())
        var tempData: Data?
        XCTAssertNil(tempData)
        tempData = encodeData(data: chapter)
        XCTAssertNotNil(tempData)
        // not sure how to test fail condition
        // maybe mock jsonencoder to test, I donot know
    }
    func testDecodeData() throws {
        let jsonData = """
            [
                {
                    "id": 1,
                    "title": "bala"
                }
            ]
            """
        let jsonData2 = """
            [
                {
                    "id": "123",
                    "title": 1
                }
            ]
            """
        var chapter: [BookChapter]?
        let data = Data(jsonData.utf8)
        let data2 = Data(jsonData2.utf8)
        print(data)
        chapter = decodeData(data: data)
        XCTAssertEqual(chapter![0].id, 1)
        chapter = decodeData(data: data2)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
