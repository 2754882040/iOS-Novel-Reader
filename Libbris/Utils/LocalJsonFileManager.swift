//
//  localJsonFileManager.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-23.
//

import Foundation

public class LocalJsonFileManager: ObservableObject {
    static let shared = LocalJsonFileManager()
    var jsonData = Data()
    var bookShelfBook: [BookInfoBriefWithTime] = [BookInfoBriefWithTime]()
    var state = LoadState.loading
    private init() {
        readData()
    }
    func readData() {
        let parsedURL = URL(fileURLWithPath: fullPath)
        state = LoadState.loading
        do {
            let tempdata = try NSData(contentsOf: parsedURL) as Data
            jsonData = tempdata
            let tempData: [BookInfoBriefWithTime]? = decodeData(data: jsonData)
            if tempData == nil {
                state = LoadState.failure
            } else {
                bookShelfBook = tempData!
                state = LoadState.success
            }
        } catch {
            print("failed")
            state = LoadState.failure
        }
        print("loading from local")

    }
    func findBookId(id: Int) -> Int {
        for num in 0..<bookShelfBook.count where bookShelfBook[num].id == id {
                print("found!\(num)")
                return num
        }
        return -1
    }
    func sortArray() {
        for num in 0..<bookShelfBook.count {
            var tempDate = bookShelfBook[num].time
            var newTimeId = num
            for secNum in num ..< bookShelfBook.count where bookShelfBook[secNum].time > tempDate {
                    tempDate = bookShelfBook[secNum].time
                    newTimeId = secNum
            }
            bookShelfBook.swapAt(num, newTimeId)
        }
    }
    func saveData(data: Data?) -> Bool {
        if data == nil {
            print("LocalJsonFileManagaer: \(#function) : empty data")
            return false
        } else {
            sortArray()
            if let tempdata = data as NSData? {
                tempdata.write(toFile: NSHomeDirectory()
                                .appending("/Documents/").appending("bookShelf"), atomically: true)
                print("LocalJsonFileManagaer: \(#function) : \(fullPath)")
                return true
            } else {return false}
        }
    }
}
