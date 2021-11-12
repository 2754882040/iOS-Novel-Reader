//
//  LibraryBook.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-10.
//

import SwiftUI

struct LibraryBook: View {
    init(bookDetail: BookInfoBrief, recommend: Bool) {
        self.bookDetail = bookDetail
        self.recommend = recommend
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var localJsonFile: LocalJsonFileManager = LocalJsonFileManager.shared
    var bookDetail: BookInfoBrief
    let recommend: Bool
    var body: some View {
        NavigationLink(destination: ReadingBookChapters(bookId: bookDetail.id)) {
            if recommend {
                coverWithIntro
            } else { coverWithIntro2 }
        }
        .contextMenu(menuItems: {
            menuAfterLongPressed
        })
    }
    var coverWithIntro: some View {
        HStack(alignment: .top) {
            BookCoverImg(url: bookDetail.cover ?? "badlink", width: 100, height: 150, alignment: .bottom)
            VStack(alignment: .leading, spacing: 1.0) {
                BookTitle(title: bookDetail.name)
                BookAuthor(author: bookDetail.authorName)
                BookSummary(summary: bookDetail.summary)
            }.frame(width: 120)
        }
    }
    var coverWithIntro2: some View {
        HStack(alignment: .top) {
            BookCoverImg(url: bookDetail.cover ?? "badlink", width: 90, height: 120, alignment: .bottom)
            VStack(alignment: .leading, spacing: 1.0) {
                BookTitle(title: bookDetail.name)
                BookSummary(summary: bookDetail.summary)
                Spacer(minLength: 25)
                BookAuthor(author: bookDetail.authorName)
            }
        }
    }
    fileprivate func addBook() {
        let tempData: BookInfoBriefWithTime = BookInfoBriefWithTime(book: bookDetail)
        let tempVar = localJsonFile.findBookId(id: tempData.id)
        if tempVar >= 0 {
            print("already in bookshelf")
            localJsonFile.bookShelfBook[tempVar].time = Date()
        } else {
            localJsonFile.bookShelfBook += [tempData]
        }
        localJsonFile.sortArray()
        _ = localJsonFile.saveData(data: encodeData(data: localJsonFile.bookShelfBook))
        NotificationCenter.default.post(name: .refreshBook, object: nil)
    }
    var menuAfterLongPressed:some View {
        Button("add to bookshelf") {
            addBook()
        }.accessibilityIdentifier("LongPressMenu")
    }
}

#if !TESTING
struct LibraryBook_Previews: PreviewProvider {
    static var previews: some View {
        LibraryBook(bookDetail: BookInfoBrief(), recommend: true)
    }
}
#endif
