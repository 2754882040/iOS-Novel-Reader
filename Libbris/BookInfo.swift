//
//  BookInfo.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import Foundation
struct BookInfo:Codable{
    var id:Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String
    var bookUrlName: String
    var lastChapterTitle: String
    var lastUpdatedDate:Int64
}
struct BookInfos:Codable{
    var result :[BookInfo]
}
struct BookChapter: Codable{
    var id:Int
    var title:String
}
struct BookChapters:Codable{
    var result:[BookChapter]
}
/*
 if let url = URL(string: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/20") {
    URLSession.shared.dataTask(with: url) { data, response, error in
     if let data = data {
     let jsonDecoder = JSONDecoder()
     do {
     let parsedJSON = try jsonDecoder.decode(BookInfo.self, from: data)
         print(parsedJSON.cover)
             } catch {
     print(error)
             }
            }
        }.resume()
 }

 */
