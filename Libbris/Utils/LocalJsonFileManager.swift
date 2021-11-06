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
            bookShelfBook = try! decodeData(data: jsonData)
            state = LoadState.success
        } catch {
            print("failed")
            state = LoadState.failure
        }
        print("loading from local")

    }
    func findBookId(id: Int) -> Int {
        for num in 0..<bookShelfBook.count {
            if bookShelfBook[num].id == id {
                print("found!\(num)")
                return num
            }
        }
        return -1
    }
    func sortArray() {
        for num in 0..<bookShelfBook.count {
            var tempDate = bookShelfBook[num].time
            var newTimeId = num
            for secNum in num ..< bookShelfBook.count {
                if bookShelfBook[secNum].time > tempDate {
                    tempDate = bookShelfBook[secNum].time
                    newTimeId = secNum
                }
            }
            bookShelfBook.swapAt(num, newTimeId)
        }
    }
    func decodeData<T: Codable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let parsedJSON = try jsonDecoder.decode(T.self, from: data)
            print("decode:\(parsedJSON)")
            return parsedJSON
        } catch {fatalError("\(error)")}
    }
    func encodeData<T: Codable>(data: T) -> Data {
        let jsonEncoder = JSONEncoder()
        let tempdata = try! jsonEncoder.encode(data)
        print(tempdata)
        return tempdata
    }
    func saveData(data: Data) {
        sortArray()
        print(fullPath)
        if let tempdata = data as NSData? {
            tempdata.write(toFile: NSHomeDirectory().appending("/Documents/").appending("bookShelf"), atomically: true)
            print("success")
            print(fullPath)}
    }
}
