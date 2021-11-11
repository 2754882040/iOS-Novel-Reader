//
//  DownloadImageTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-10.
//

import XCTest
@testable import Libbris
class DownloadImageTests: XCTestCase {
    var testObject: Loader?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckFileExist() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        XCTAssertEqual(testObject!.checkFileExist(filePath: testFilePath), false)
        let fileURL = URL(fileURLWithPath: testFilePath)
        let emptyFile = FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        print("\(#function) : \(emptyFile)")
        print("\(#function) : \(testFilePath)")
        XCTAssertEqual(testObject!.checkFileExist(filePath: testFilePath), true)
    }
    func testLastModifyDate() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        let fileURL = URL(fileURLWithPath: testFilePath)
        let emptyFile = FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        print("\(#function) : \(emptyFile)")
        print("\(#function) : \(testFilePath)")
        XCTAssertNotNil(testObject!.lastModifyDate(filePath: testFilePath))
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        XCTAssertNil(testObject!.lastModifyDate(filePath: testFilePath))
    }
    func testCheckImageNeedUpdate() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        let fileURL = URL(fileURLWithPath: testFilePath)
        let emptyFile = FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        print("\(#function) : \(emptyFile)")
        print("\(#function) : \(testFilePath)")
        print("\(#function) : \(Date())")
        XCTAssertFalse(testObject!.checkImageNeedUpdate(filePath: testFilePath, interval: 3600))
        sleep(2)
        XCTAssertTrue(testObject!.checkImageNeedUpdate(filePath: testFilePath, interval: 1))
    }
//    func testLoadDataSuccess() throws {
//        testObject = Loader()
//    }
//    func testLoadDataFail() throws {
//        testObject = Loader()
//    }
    func testKeepCheckInBackgroundSuccess() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")

        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        testObject!.keepCheckInBackground(filePath: testFilePath, name: "testFile", URLString: testURL, interval: 1)
        while testObject?.keepCheck != .running {}
        XCTAssertTrue(testObject!.keepCheck == .running)
        while testObject?.imagefileStatus != .downloadSuccess {}
        XCTAssertTrue(testObject!.imagefileStatus == .downloadSuccess)
    }
    func testKeepCheckInBackgroundFail() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        testObject?.keepCheckInBackground(filePath: testFilePath, name: "testFile", URLString: "4312", interval: 50)
        while testObject?.keepCheck != .running {}
        XCTAssertTrue(testObject!.keepCheck == .running)
    }
    func testKeepCheckInBackgroundFail2() throws {
        testObject = Loader()
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        do {
            try FileManager.default.removeItem(atPath: testFilePath)
        } catch {print("file does not exist!")}
        testObject?.keepCheckInBackground(filePath: testFilePath, name: "testFile", URLString: "", interval: 50)
        while testObject?.keepCheck != .running {}
        XCTAssertTrue(testObject!.keepCheck == .running)
    }
    func testSaveData() throws {
        testObject = Loader()
        let testImg1 = UIImage(named: "AppIcon")
        let testImg2 = UIImage()
        XCTAssertTrue(
            testObject!.saveData(currentImage: testImg1!, persent: 10, imageName: "AppIcon"))
        XCTAssertFalse(
            testObject!.saveData(currentImage: testImg2, persent: 10, imageName: "empty"))
    }
}
let testURL = "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg"
