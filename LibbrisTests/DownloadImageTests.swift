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
        testObject = Loader()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testObject = nil
    }

    func testCheckFileExist() throws {
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        let fileURL = URL(fileURLWithPath: testFilePath)
        let emptyFile = FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        print("\(#function) : \(emptyFile)")
        print("\(#function) : \(testFilePath)")
        XCTAssertEqual(testObject!.checkFileExist(filePath: testFilePath), true)
        // swiftlint:disable force_try
        try! FileManager.default.removeItem(atPath: testFilePath)
        // swiftlint:enable force_try
        XCTAssertEqual(testObject!.checkFileExist(filePath: testFilePath), false)
    }
    func testLastModifyDate() throws {
        let testFilePath = NSHomeDirectory().appending("/Documents/testFile")
        let fileURL = URL(fileURLWithPath: testFilePath)
        let emptyFile = FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        print("\(#function) : \(emptyFile)")
        print("\(#function) : \(testFilePath)")
        XCTAssertNotNil(testObject!.lastModifyDate(filePath: testFilePath))
        // swiftlint:disable force_try
        try! FileManager.default.removeItem(atPath: testFilePath)
        // swiftlint:enable force_try
        XCTAssertNil(testObject!.lastModifyDate(filePath: testFilePath))
    }
    func testCheckImageNeedUpdate() throws {
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
    func testLoadData() throws {
//        var testObjData: UIImage?
//        var testObjError: Error?
//        testObject!.loadData(URLString: <#T##String#>, completionHandler: { (img, error) -> Void in
//            testObjData = img
//            testObjError = error
//        })
    }
    func testSaveData() throws {
        let testImg1 = UIImage(named: "AppIcon")
        let testImg2 = UIImage()
        XCTAssertTrue(
            testObject!.saveData(currentImage: testImg1!, persent: 10, imageName: "AppIcon"))
        XCTAssertFalse(
            testObject!.saveData(currentImage: testImg2, persent: 10, imageName: "empty"))
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
