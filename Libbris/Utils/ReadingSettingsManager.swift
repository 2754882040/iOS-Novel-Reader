//
//  ReadingSettingsManager.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-12-08.
//

import Foundation

public class ReadingSettingsManager: ObservableObject {
    var jsonData = Data()
    var percent: LastRead = LastRead()
    // var bookId: Int
    var state = LoadState.loading
    let fileUrl: String
    init(_ id: Int) {
        // bookId = id
        fileUrl = NSHomeDirectory().appending("/Documents/").appending("book\(id)")
        readData()
    }
    func readData() {
        let parsedURL = URL(fileURLWithPath: fileUrl)
        state = LoadState.loading
        do {
            let tempdata = try NSData(contentsOf: parsedURL) as Data
            jsonData = tempdata
            let tempData: LastRead? = decodeData(data: jsonData)
            if tempData == nil {
                state = LoadState.failure
            } else {
                percent = tempData!
                state = LoadState.success
            }
        } catch {
            state = LoadState.failure
        }
    }
    func saveData() -> Bool {
        let tempData = encodeData(data: percent)
        if tempData == nil {
            print("ReadingSettingsManager: \(#function) : empty data")
            return false
        } else {
            if let tempdata = tempData as NSData? {
                tempdata.write(toFile: fileUrl, atomically: true)
                print("ReadingSettingsManager: \(#function) : \(fileUrl)")
                return true
            } else {return false}
        }
    }
}
