//
//  DownloadJson.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import Foundation
import SwiftUI

public class DownloadJson: ObservableObject {
    enum LoadState {
            case loading, success, failure
        }
    var jsonData = Data()
    var state = LoadState.loading
    init(url: String) {
        getData(URLString: url)
    }
    init() {}
    func getData(URLString: String) {
        state = LoadState.loading
        DownloadData.request(urlString: URLString, completion: { result in
            switch result {
            case .failure(let error):
                // do something with `error`
                print(error)
                self.state = .failure
            case .success(let data):
                // do something with `data`
                print("success")
                self.jsonData = data
                self.state = .success
                }
        })
    }
    #if !TESTING
    func getLocalFileDir(fileName: String) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let pathWithFilename = documentDirectory!.appendingPathComponent(fileName)
        return pathWithFilename
    }
    #endif
    func saveData(data: Data, fileName: String) {
        let saveFilePath = NSHomeDirectory().appending("/Documents/\(fileName)")
        let saveFileURL = URL(fileURLWithPath: saveFilePath)
        do {
            try data.write(to: saveFileURL)
        } catch {}
    }
}
