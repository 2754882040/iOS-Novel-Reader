//
//  DownloadImage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-19.
//

import Foundation
import SwiftUI

enum NetworkErrorHandle: Error {
    case networkIssues
    case imageFormatIssues
    case urlIssues
}
enum ImageStatus {
    case checkFileExist, checkUpdate, downloadSuccess, downloadFail, saveSuccess, saveFail, notStart
}
enum BackgroundCheck {
    case running, notRunning
}
public class Loader: ObservableObject {
    var filePath: String = NSHomeDirectory().appending("/Documents/")
    var imageName: String
    var data = Data()
    var downloadError: Error?
    var imagefileStatus: ImageStatus = .notStart
    var keepCheck: BackgroundCheck = .notRunning
    init(url: String, name: String) {
        imageName = name
        imageLoadingController(filePath: NSHomeDirectory().appending("/Documents/\(imageName)"),
                               name: imageName,
                                    URLString: url, interval: 3600)
        keepCheckInBackground(filePath: NSHomeDirectory().appending("/Documents/\(imageName)"),
                              name: imageName, URLString: url, interval: 3600)
        // imageFileManagment(URLString: url)
        // imageNeedUpdate(DATE: Date(), URLString: url)
        }
    init() {
        imageName = "testFile"
    } // for test init
    func checkFileExist(filePath: String) -> Bool {
        imagefileStatus = .checkFileExist
        do {
            _ = try FileManager.default.attributesOfItem(atPath: filePath)
            print("\(#function) File exist!")
        } catch let error as NSError {
            print("\(#function) Error: \(error)")
            return false
        }
        return true
    }
    func lastModifyDate(filePath: String) -> Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: filePath)
            // swiftlint:disable line_length
            print("\(#function) last modify date: \(String(describing: attr[FileAttributeKey.modificationDate] as? Date))")
            // swiftlint:enable line_length
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch let error as NSError {
            print("\(#function) Error: \(error)")
            return nil
        }
    }
    func checkImageNeedUpdate(filePath: String, interval: TimeInterval) -> Bool {
        imagefileStatus = .checkUpdate
        let fileTimeStamp = lastModifyDate(filePath: filePath)
        let tempTime = fileTimeStamp!.addingTimeInterval(interval)
        if tempTime < Date() {
            print("\(#function) File need update!")
            return true
        } else {
            print("\(#function) File do not need update!")
            return false
        }
    }
    func loadData(URLString: String,
                  completionHandler: @escaping (UIImage?, Error?) -> Void) {
        guard let parsedURL = URL(string: URLString) else {
            self.imagefileStatus = .downloadFail
            print("\(#function) please provide valid URL!")
            return completionHandler(nil, NetworkErrorHandle.urlIssues)
        }
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
                    guard let img = UIImage(data: data ?? Data()) else {
                        print("\(#function) image data can not change to UIImage!")
                        self.imagefileStatus = .downloadFail
                        return completionHandler(nil, NetworkErrorHandle.imageFormatIssues)
                    }
                    print("\(#function) image download successfully!")
                    self.imagefileStatus = .downloadSuccess
                    completionHandler(img, nil)
            }.resume()
        }
    }
    func saveData(currentImage: UIImage, persent: CGFloat, imageName: String) -> Bool {
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
            let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("\(#function)  save success! fullPath=\(fullPath)")
            imagefileStatus = .saveSuccess
            return true
        } else {
            imagefileStatus = .saveFail
            print("\(#function) image can not save")
            return false
        }
    }
    func loadAndSaveData(URLString: String, persent: CGFloat, imageName: String) {
        loadData(URLString: URLString, completionHandler: { (img, error) -> Void in
            if error == nil {
                _ = self.saveData(currentImage: img!, persent: persent, imageName: imageName)
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            } else {
                self.downloadError = error
            }
        })
    }
    func imageLoadingController(filePath: String, name: String,
                                URLString: String, interval: TimeInterval) {
        if checkFileExist(filePath: filePath) {
            if checkImageNeedUpdate(filePath: filePath, interval: interval) {
                loadAndSaveData(URLString: URLString, persent: 10, imageName: name)
            }
        } else {
            loadAndSaveData(URLString: URLString, persent: 10, imageName: name)
        }
    }
    func keepCheckInBackground(filePath: String, name: String, URLString: String, interval: TimeInterval) {
        DispatchQueue.global(qos: .background).async {
            self.keepCheck = .running
            while true {
                print("\(#function) background: check for update!")
                self.imageLoadingController(filePath: filePath, name: name, URLString: URLString, interval: interval)
                sleep(UInt32(interval))
            }
        }
    }
}
