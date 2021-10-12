//
//  localJsonFileManager.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-23.
//

import Foundation

public class localJsonFileManager: ObservableObject {
 
    static let shared = localJsonFileManager()
    var jsonData = Data();
    var bookShelfBook:[BookInfoBriefWithTime] = [BookInfoBriefWithTime]()
    var state = LoadState.loading
    private init(){
        readData()
    }
   
    func readData(){
        let parsedURL = URL(fileURLWithPath: fullPath)
        state = LoadState.loading
        do{
            let tempdata = try NSData(contentsOf:parsedURL) as Data
            jsonData = tempdata
            bookShelfBook = try! decodeData(data: jsonData)
            state = LoadState.success
        }
        catch{
            print("failed")
            state = LoadState.failure
            
        }
        print("loading from local")

    }
    func findBookId(id:Int)->Int{
        for i in 0..<bookShelfBook.count{
            if bookShelfBook[i].id == id{
                print("found!\(i)")
                return i
            }
        }
        return -1
    }
    
    func sortArray(){
        for i in 0..<bookShelfBook.count{
            var tempDate = bookShelfBook[i].time
            var newTimeId = i
            for j in i..<bookShelfBook.count{
                if bookShelfBook[j].time > tempDate{
                    tempDate = bookShelfBook[j].time
                    newTimeId = j
                }
            }
            bookShelfBook.swapAt(i, newTimeId)
        }
    }
    
    func decodeData<T:Codable>(data:Data)throws->T{
        
        let jsonDecoder = JSONDecoder()
        do {
            let parsedJSON = try jsonDecoder.decode(T.self, from: data)
            print("decode:\(parsedJSON)")
            return parsedJSON
        } catch {fatalError("\(error)")}
        
    }
    
    func encodeData<T:Codable>(data:T)->Data{
        let jsonEncoder = JSONEncoder()
        let tempdata = try! jsonEncoder.encode(data)
        print(tempdata)
        return tempdata
    }
    
    func saveData(data:Data){
        sortArray()
        print(fullPath)
        if let tempdata = data as NSData? {
            tempdata.write(toFile: NSHomeDirectory().appending("/Documents/").appending("bookShelf"), atomically: true)
            print("success")
            print(fullPath)}
        
    }
        
}
