//
//  BookInfo.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import Foundation
import SwiftUI
struct BookInfo: Codable {
    var id: Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String
    var bookUrlName: String
    var lastChapterTitle: String
    var lastUpdatedDate: Int64
}
struct BookInfoBrief: Codable, Hashable {
    var id: Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String?
    var bookUrlName: String
    init() {
    id = 0
    name = " "
    authorName = " "
    summary = " "
    cover = " "
    bookUrlName = " "
    }
}
struct BookInfoBriefWithTime: Codable, Hashable, Comparable {
    static func < (lhs: BookInfoBriefWithTime, rhs: BookInfoBriefWithTime) -> Bool {
        if lhs.time > rhs.time {
            return true
        } else {
            return false
        }
    }
    init() {
    id = 0
    name = " "
    authorName = " "
    summary = " "
    cover = " "
    bookUrlName = " "
    time = Date()
    }
    init(book: BookInfoBrief) {
        id = book.id
        authorName = book.authorName
        bookUrlName = book.bookUrlName
        cover = book.cover
        time = Date()
        name = book.name
        summary = book.summary
    }
    var id: Int
    var name: String
    var authorName: String
    var summary: String
    var cover: String?
    var bookUrlName: String
    var time: Date
}
struct BookChapter: Codable, Identifiable {
    var id: Int
    var title: String
    init() {
        id = 0
        title = " "
    }
}

struct AlertInfo: Identifiable {
    var id: String { name }
    let name: String
}

struct LastRead: Codable {
    var percent: Double
    var chapterId: Int
    init() {
        percent = 0.0
        chapterId = 0
    }
    init(val: Double, Id: Int) {
        percent = val
        chapterId = Id
    }
}

