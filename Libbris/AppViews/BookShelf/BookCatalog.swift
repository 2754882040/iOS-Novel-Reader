//
//  BookCatalog.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-11-17.
//

import SwiftUI

struct BookCatalog: View {
    init(bookId: Int) {
        _datas = StateObject(wrappedValue: DownloadJson(url: getAllChaptersAPI(bookId: bookId)))
        self.bookId = bookId
    }
    let screenSize: CGRect = UIScreen.main.bounds
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var chapters: [BookChapter] = [BookChapter]()
    @StateObject public var datas: DownloadJson
    @State var bookId: Int = 1
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "arrow.left")
                    .resizable()
                    .padding([.top, .leading], 10.0)
                    .frame(width: screenSize.height * 0.05, height: screenSize.height * 0.04, alignment: .center)})
                Spacer()
            }
            if chapters.count == 0 {
                Text("loading").onAppear(perform: {
                    DispatchQueue.global(qos: .background).async {
                    while datas.state == .loading {}
                    if datas.state == .success {
                        var decodedBookData: [BookChapter]?
                        decodedBookData = decodeData(data: datas.jsonData)
                        if decodedBookData != nil && !decodedBookData!.isEmpty {
                            chapters += decodedBookData!
                        }
                    }
                    }
                })
            } else {
                let index: Int = chapters.count
                List(0..<index) {idx in
                    Text(chapters[idx].title).accessibilityIdentifier("ChapterButton\(idx)")
                }
            }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct BookCatalog_Previews: PreviewProvider {
    static var previews: some View {
        BookCatalog(bookId: 77)
    }
}
