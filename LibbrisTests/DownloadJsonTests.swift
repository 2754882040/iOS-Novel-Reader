//
//  DownloadJsonTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class DownloadJsonTests: XCTestCase {

    func testGetDataSuccess() throws {
        let testObj = DownloadJson()
        testObj.jsonData = Data()
        testObj.state = .loading
        // swiftlint:disable line_length
        testObj.getData(URLString: "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg")
        // swiftlint:enable line_length
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .success)
    }
    func testGetDataFail() throws {
        let testObj = DownloadJson()
        testObj.jsonData = Data()
        testObj.state = .loading
        testObj.getData(URLString: "asda")
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .failure)
    }
    func testSaveData() throws {
        let testObj = DownloadJson()
        let testFilePath = NSHomeDirectory().appending("/Documents/downloadJsonTestfile")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        testObj.saveData(data: Data(), fileName: "downloadJsonTestfile")
        XCTAssertTrue(FileManager.default.fileExists(atPath: testFilePath))
    }
}
