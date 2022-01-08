//
//  BookList.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-15.
//

import SwiftUI

struct BookList: View {
    init(url: String, cId: Int) {
        _datas = StateObject(wrappedValue: DownloadJson(url: url))
        self.categoryId = cId
        self.url = url
        self.searchOn = false
    }
    init(url: String) {
        _datas = StateObject(wrappedValue: DownloadJson(url: url))
        self.categoryId = 0
        self.url = url
        self.searchOn = true
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var books: [BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    @State var loadingText = localizedString(text: strLoading)
    @State var noBooksText = localizedString(text: strNoMoreBook)
    @State var noMoreBook: Bool = false
    @State var curBookCount: Int = 0
    @State var searchOn: Bool = false
    let url: String
    let categoryId: Int
    let screenSize: CGRect = UIScreen.main.bounds
    var loadMore: some View {
        Text("loading").accessibilityIdentifier("textLoading")
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ScrollView(.vertical) {
                if books.count == 0 {
                    if datas.state == .loading {
                        VStack {
                            Text(loadingText).font(.custom("Dosis-Regular", size: 12))
                        }.frame(height: 240, alignment: .center)
                    } else {
                        VStack {
                            Text(noBooksText).font(.custom("Dosis-Regular", size: 12))
                        }.frame(height: 240, alignment: .center)
                    }
                    
                } else {
                    let items = 0...(books.count-1)
                    LazyVStack {
                        ForEach(items, id: \.self) { item in
                            LibraryBook(bookDetail: books[item], recommend: false)
                                .accessibilityIdentifier("LibraryBook\(item)")
                            Spacer(minLength: 20)
                        }
                        if noMoreBook {
                            Text(noBooksText)
                            .accessibilityIdentifier("textNoMoreBooks")}
                         else if searchOn == false {
                            loadMore.onAppear(perform: {loadBook()})}
                        Spacer(minLength: 10)
                    }
                }
            }.frame(width: screenSize.width)
        }.onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
            while datas.state == .loading {}
            if datas.state == .success {
                var decodedBookData: [BookInfoBrief]?
                decodedBookData = decodeData(data: datas.jsonData)
                if decodedBookData != nil && !decodedBookData!.isEmpty {
                    books += decodedBookData!
                }
                curBookCount = books.count
            }
            }
        }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.loadingText = localizedString(text: strLoading)
            self.noBooksText = localizedString(text: strNoMoreBook)
        })
    }
    func loadBook() {
        curBookCount = books.count
        datas.getData(URLString: getBookByCategoryAPI(categoryId: categoryId, start: curBookCount+1, size: 20))
        print("loading book")
        DispatchQueue.global(qos: .background).async {
            while datas.state == .loading {
                sleep(1)
                print("sleep")
            }
            if datas.state == .success {
                var decodedBookData: [BookInfoBrief]?
                decodedBookData = decodeData(data: datas.jsonData)
                if decodedBookData != nil && !decodedBookData!.isEmpty {
                    books += decodedBookData!
                }
                if curBookCount != books.count {
                    curBookCount = books.count
                } else {
                    noMoreBook = true
                    print(books.count)
                }
            }
        }
    }
}
#if !TESTING
struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=1&size=9", cId: 11)
    }
}
#endif
