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
            case loading,success,failure
        }
    
    var jsonData = Data();
    var state = LoadState.loading
    init(url: String) {
        getData(URLString: url)
    }

    func getData(URLString:String){
        guard let parsedURL = URL(string: URLString) else {
            fatalError("Invalid URL: \(URLString)")
        }
        state = LoadState.loading
        getData(url:parsedURL)
    }
    
    func getData(url:URL){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, data.count > 0 {
                self.jsonData = data
                self.state = .success
            } else {
                self.state = .failure
                print("failed")
            }
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
    
    
    func decodeData<T:Codable>(data:Data)throws->T{
        
        let jsonDecoder = JSONDecoder()
        do {
            let parsedJSON = try! jsonDecoder.decode(T.self, from: data)
            return parsedJSON
        }
        
    }
    
    func getLocalFileDir(fileName:String)->URL{
        let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first
        let pathWithFilename = documentDirectory!.appendingPathComponent(fileName)
        return pathWithFilename
        
    }
    
    func saveData(data:Data, fileName:String){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(fileName)
            do {
                try! data.write(to: pathWithFilename)
                print("success")
                print(pathWithFilename)
            }
        }
    }

    
}
