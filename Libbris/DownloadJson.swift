//
//  DownloadJson.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import Foundation
import SwiftUI

public class DownloadJson: ObservableObject {
    var jsonData:[BookInfo] = []
    
    //var state = LoadState.loading

    init(url: String) {
        tempData(URLString: url)
        }
    
    func tempData(URLString:String){
        guard let parsedURL = URL(string: URLString) else {
            fatalError("Invalid URL: \(URLString)")
        }
            
        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data {
            let jsonDecoder = JSONDecoder()
            do {
            let parsedJSON = try jsonDecoder.decode([BookChapter].self, from: data)
                print("balabala")
                print(parsedJSON)
                    } catch {
            print(error)
                    }
                   }
               }.resume()
            
            
        
    }
    func backgroundCheckImageUpdate(DATE:Date,URLString: String){
        var tempTimeVar = DATE
        DispatchQueue.global(qos: .background).async {
            while (true){
                print("background thread runing")
                let tempTime = tempTimeVar.addingTimeInterval(3600)
                if (tempTime < Date()){
                    self.downloadImage(URLString: URLString)
                    tempTimeVar = Date()
                }
                else{
                    print("do not need download image,sleep for 3600s for next update")
                    sleep(3600)
                }
            }
        }
    }
    
    func downloadImage(URLString:String){
            guard let parsedURL = URL(string: URLString) else {
                fatalError("Invalid URL: \(URLString)")
            }
            let lastModifyDate = lastModified()
            if(lastModifyDate != nil){
                let lastModifyDateNotNil = lastModifyDate!.addingTimeInterval(86400)
                if (lastModifyDateNotNil < Date()){
                    print("need update image")
                    getDataFromInternet(parsedURL:parsedURL)
                }
                else{
                    print("image is already updated")
                }
            }else{
                print("need download image")
                getDataFromInternet(parsedURL:parsedURL)
            }
        
    }
    func getDataFromInternet(parsedURL:URL){
        DispatchQueue.global(qos: .background).async {
            print("download in background")
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let img = UIImage(data: data!) {
                    self.saveImage(currentImage: img, persent: 10, imageName: "123")
                }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    func lastModified() -> Date? {
        let fileDir =  NSHomeDirectory().appending("/Documents/123")
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: fileDir)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch let error as NSError {
            print("\(#function) Error: \(error)")
            return nil
        }
    }
    
    public func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String){
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
                let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
                imageData.write(toFile: fullPath, atomically: true)
                print("fullPath=\(fullPath)")
            
            }
        
    }
    
}
