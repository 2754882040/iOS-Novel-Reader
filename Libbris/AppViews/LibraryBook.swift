//
//  LibraryBook.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-10.
//

import SwiftUI

struct LibraryBook: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var loader: ImageLoader
    @StateObject var localJsonFile: localJsonFileManager = localJsonFileManager.shared
    
    var loading: Image
    var failure: Image
    var bookDetail:BookInfoBrief
    
    init(bookDetail: BookInfoBrief, loading: Image = Image("default_cover"), failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: bookDetail.cover ?? "badlink"))
        self.loading = loading
        self.failure = failure
        self.bookDetail = bookDetail
    }
    
    var body: some View {
        NavigationLink(destination: BookDetailView(bookId:bookDetail.id)){
            HStack(alignment: .top){
                selectImage().resizable().frame(width: 90, height: 120, alignment: .bottom)
                VStack(alignment: .leading, spacing: 3.0){
                    Text("\(bookDetail.name)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Bold", size: 17))
                    Text("\(bookDetail.summary)").lineLimit(3).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                    Spacer(minLength: 25)
                    Text("\(bookDetail.authorName)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                }
                Spacer()
            }
        }
        .contextMenu(menuItems: {
            Button("add to bookshelf"){
                let tempData: BookInfoBriefWithTime = BookInfoBriefWithTime(book: bookDetail)
                let tempVar = localJsonFile.findBookId(id: tempData.id)
                if(tempVar >= 0){
                    print("already in bookshelf")
                    localJsonFile.bookShelfBook[tempVar].time = Date()
                }else{
                    localJsonFile.bookShelfBook += [tempData]
                }
                localJsonFile.sortArray()
                localJsonFile.saveData(data: localJsonFile.encodeData(data: localJsonFile.bookShelfBook))
                NotificationCenter.default.post(name: .refreshBook, object: nil)
            }.accessibilityIdentifier("LongPressMenu")
        })
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
struct LibraryBook_Previews: PreviewProvider {
    static var previews: some View {
        BookButton(bookDetail: <#BookInfoBrief#>)
    }
}*/
