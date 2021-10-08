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
struct BookInfoBrief:Codable,Hashable{
    var id:Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String?
    var bookUrlName: String
}
struct BookInfoBriefWithTime:Codable,Hashable,Comparable{
    static func < (lhs: BookInfoBriefWithTime, rhs: BookInfoBriefWithTime) -> Bool {
        if lhs.time > rhs.time{
            return true
        }else{
            return false
        }
    }
    init(){
    id = 0
    name = " "
    authorName = " "
    summary = " "
    cover = " "
    bookUrlName = " "
    time = Date()
    }
    init(id:Int,name:String, authorName:String,summary:String,cover:String,bookUrlName:String){
        self.id = id
        self.name = name
        self.authorName = authorName
        self.summary = summary
        self.cover = cover
        self.bookUrlName = bookUrlName
        self.time = Date()
    }
    
    var id:Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String?
    var bookUrlName: String
    var time: Date
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

