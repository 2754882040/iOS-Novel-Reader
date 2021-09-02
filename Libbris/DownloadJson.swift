//
//  DownloadJson.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import Foundation
import SwiftUI

extension URLSession {
    func dataTask(
        with url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}

public class DownloadJson: ObservableObject {
    enum LoadState {
            case loading, success, failure
        }
    var jsonData = Data();
    var state = LoadState.loading
    init(){//url: String) {
        //getData(URLString: url)
        //getData(url: getLocalFileDir(fileName:url))
    }

    func getData(URLString:String){
        guard let parsedURL = URL(string: URLString) else {
            fatalError("Invalid URL: \(URLString)")
        }
        getData(url:parsedURL)
    }
    
    func getData(url:URL){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, data.count > 0 {
                self.jsonData = data
                self.saveData(data: self.jsonData,fileName: "myJsonString.json")
                self.state = .success
            } else {
                self.state = .failure
            }

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
        
        /*URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                self.jsonData = data
                self.saveData(data: self.jsonData,fileName: "myJsonString.json")
            }
        }.resume()*/
    }
    
    
    func decodeData<T:Codable>(data:Data)throws->T{
        
        let jsonDecoder = JSONDecoder()
        do {
            let parsedJSON = try jsonDecoder.decode(T.self, from: self.jsonData)
            print(parsedJSON)
            return parsedJSON
        } catch {
            print(error)
            fatalError("\(error)")
        }
        
    }
    
    func getLocalFileDir(fileName:String)->URL{
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(fileName)
            return pathWithFilename
        }else{fatalError("did not found")}
    }
    
    func saveData(data:Data, fileName:String){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(fileName)
            do {
                try data.write(to: pathWithFilename)
                print("success")
                print(pathWithFilename)
            } catch {
                // Handle error
            }
        }
        let test:[BookChapter] = try! readData(data:data,fileName: "myJsonString.json")
    }
    
    func readData<T:Codable>(data:Data,fileName:String)throws->T{
        do {
            let parsedJSON:T = try! decodeData(data: data)
            print("balabal")
            print(parsedJSON)
            return parsedJSON
        } catch {
                    print(error)
                    fatalError("\(error)")
                }
    }
    
}
