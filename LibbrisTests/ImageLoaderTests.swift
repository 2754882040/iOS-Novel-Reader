//
//  ImageLoaderTests.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class ImageLoaderTests: XCTestCase {
    func testRefreshSuccess() throws {
        let testObj = ImageLoader()
        // swiftlint:disable line_length
        testObj.refresh(url: "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg")
        // swiftlint:enable line_length
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .success)
        XCTAssertNotEqual(testObj.data, Data())
    }
    func testRefreshFail() throws {
        let testObj = ImageLoader()
        testObj.refresh(url: "asdas")
        while testObj.state == .loading {}
        XCTAssertTrue(testObj.state == .failure)
        XCTAssertEqual(testObj.data, Data())
    }
}
