//
//  DownloadDataTest.swift
//  LibbrisTests
//
//  Created by 郝育宽 on 2021-11-11.
//

import XCTest
@testable import Libbris
class DownloadDataTest: XCTestCase {
    func testRequestSuccess() throws {
        var testData = Data()
        var state = LoadState.loading
        let urlString = "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg"
        DownloadData.request(urlString: urlString, completion: { result in
            switch result {
            case .failure(let error):
                print(error)
                state = .failure
            case .success(let data):
                print("success")
                testData = data
                state = .success
                }
        })
        while state == .loading {}
        XCTAssertEqual(state, LoadState.success)
        XCTAssertNotEqual(testData, Data())
    }
    func testRequestFail() throws {
        var testData = Data()
        var state = LoadState.loading
        let urlString = "asda"
        DownloadData.request(urlString: urlString, completion: { result in
            switch result {
            case .failure(let error):
                print(error)
                state = .failure
            case .success(let data):
                print("success")
                testData = data
                state = .success
                }
        })
        while state == .loading {}
        XCTAssertEqual(state, LoadState.failure)
        XCTAssertEqual(testData, Data())
    }
}
