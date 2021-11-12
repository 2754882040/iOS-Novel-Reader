//
//  LocalJsonFileManagerTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class LocalJsonFileManagerTests: XCTestCase {
    func testReadDataSuccess() throws {
        let testObj = LocalJsonFileManager.shared
        testObj.jsonData = Data()
        testObj.state = .loading
        let testFilePath = NSHomeDirectory().appending("/Documents/bookShelf")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file not exist!")}
        let fileURL = URL(fileURLWithPath: testFilePath)
        let testString = "[]"
        let data = Data(testString.utf8)
        _ = FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        testObj.readData()
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .success)
    }
    func testReadDataFail() throws {
        let testObj = LocalJsonFileManager.shared
        testObj.jsonData = Data()
        testObj.state = .loading
        let testFilePath = NSHomeDirectory().appending("/Documents/bookShelf")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file not exist!")}
        let fileURL = URL(fileURLWithPath: testFilePath)
        let testString = "[123]"
        let data = Data(testString.utf8)
        _ = FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        testObj.readData()
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .failure)
    }
    func testFindBookId() throws {
        let testObj = LocalJsonFileManager.shared
        testObj.jsonData = Data()
        testObj.state = .loading
        let testFilePath = NSHomeDirectory().appending("/Documents/bookShelf")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file not exist!")}
        let fileURL = URL(fileURLWithPath: testFilePath)
        let data = Data(testJsonData.utf8)
        _ = FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        testObj.readData()
        XCTAssertEqual(0, testObj.findBookId(id: 76))
        XCTAssertEqual(-1, testObj.findBookId(id: 75))
    }
    func testSortArray() throws {
        let testObj = LocalJsonFileManager.shared
        testObj.jsonData = Data()
        testObj.state = .loading
        let testFilePath = NSHomeDirectory().appending("/Documents/bookShelf")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file not exist!")}
        let fileURL = URL(fileURLWithPath: testFilePath)
        let data = Data(testJsonData.utf8)
        _ = FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        testObj.readData()
        XCTAssertEqual(0, testObj.findBookId(id: 76))
        testObj.sortArray()
        XCTAssertEqual(0, testObj.findBookId(id: 78))
    }
    func testSaveData() throws {
        let testObj = LocalJsonFileManager.shared
        XCTAssertEqual(testObj.saveData(data: Data()), true)
        XCTAssertEqual(testObj.saveData(data: nil), false)
    }
}
// swiftlint:disable line_length
let testJsonData: String = """
[{"summary":" ","time":658368540.27515197,"id":76,"bookUrlName":" ","authorName":" ","cover":" ","name":" "},{"summary":" ","time":658368538.07625794,"id":77,"bookUrlName":" ","authorName":" ","cover":" ","name":" "},{"summary":" ","time":658368724.62758696,"id":78,"bookUrlName":" ","authorName":" ","cover":" ","name":" "}]
"""
// swiftlint:enable line_length
