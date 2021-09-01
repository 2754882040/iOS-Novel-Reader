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
    init(url: String) {
        tempData(URLString: url)
    }
    
    func tempData(URLString:String){
        guard let parsedURL = URL(string: URLString) else {
            fatalError("Invalid URL: \(URLString)")
        }
            
        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data {
                self.saveData(data: data)
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
    
    func saveData(data:Data){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            do {
                try data.write(to: pathWithFilename)
                print("success")
                print(pathWithFilename)
            } catch {
                // Handle error
            }
        }
        readData()
    }
    
    func readData(){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            URLSession.shared.dataTask(with: pathWithFilename) { data, response, error in
                if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                let parsedJSON = try jsonDecoder.decode([BookChapter].self, from: data)
                    print("1231451")
                    print(parsedJSON)
                } catch {
                            print(error)
                        }
                }
            }.resume()
        }
    }
}
