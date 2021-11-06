//
//  LibraryBookRecommend.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-14.
//

import SwiftUI

struct LibraryBookRecommend: View {
    init(bookDetail: BookInfoBrief, loading: Image = Image("default_cover"), failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: bookDetail.cover ?? "badlink" ))
        self.loading = loading
        self.failure = failure
        self.bookDetail = bookDetail
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var localJsonFile: LocalJsonFileManager = LocalJsonFileManager.shared
    @StateObject private var loader: ImageLoader
    var loading: Image
    var failure: Image
    var bookDetail: BookInfoBrief
    var body: some View {
        NavigationLink(destination: ReadingBookChapters(bookId: bookDetail.id)) {
            coverWithIntro
        }
        .contextMenu(menuItems: {
            menuAfterLongPressed
        })
    }
    var coverWithIntro: some View {
        HStack(alignment: .top) {
            selectImage().resizable().frame(width: 100, height: 150, alignment: .bottom)
            VStack(alignment: .leading, spacing: 1.0) {
                Text("\(bookDetail.name)")
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.custom("Dosis-Bold", size: 17))
                Text("\(bookDetail.authorName)")
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .font(.custom("Dosis-Regular", size: 12))
                Text("\(bookDetail.summary)")
                    .lineLimit(3)
                    .foregroundColor(.black)
                    .font(.custom("Dosis-Regular", size: 12))
            }.frame(width: 120)
        }
    }
    var menuAfterLongPressed:some View {
        Button("add to bookshelf") {
            let tempData: BookInfoBriefWithTime = BookInfoBriefWithTime(book: bookDetail)
            let tempVar = localJsonFile.findBookId(id: tempData.id)
            if tempVar >= 0 {
                print("already in bookshelf")
                localJsonFile.bookShelfBook[tempVar].time = Date()
            } else {
                localJsonFile.bookShelfBook += [tempData]
            }
            localJsonFile.sortArray()
            localJsonFile.saveData(data: localJsonFile.encodeData(data: localJsonFile.bookShelfBook))
            NotificationCenter.default.post(name: .refreshBook, object: nil)
        }.accessibilityIdentifier("LongPressMenu")
    }
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
/*
struct LibraryBookRecommend_Previews: PreviewProvider {
    static var previews: some View {
        LibraryBookRecommend()
    }
}*/
