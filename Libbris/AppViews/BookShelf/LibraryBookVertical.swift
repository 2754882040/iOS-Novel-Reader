//
//  LibraryBookVertical.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-14.
//

import SwiftUI

struct LibraryBookVertical: View {
    init() {
        _datas = StateObject(wrappedValue: DownloadJson(url: getBookByCategoryAPI(categoryId: 11, start: 1, size: 9)))
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var books: [BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    @State var loadingText = localizedString(text: strLoading)
    var body: some View {
        ScrollView(.horizontal) {
            if books.count == 0 {
                HStack(alignment: .center) {
                    Text(loadingText).font(.custom("Dosis-Regular", size: 12))
                }.frame(height: 300, alignment: .center)
            } else {
                let items = 0...(books.count-1)
                let rows = [GridItem(), GridItem()]
                LazyHGrid(rows: rows) {
                    ForEach(items, id: \.self) { item in
                        LibraryBookRecommend(bookDetail: books[item])
                            .accessibilityIdentifier("LibraryBookRecommend\(item)")
                    }
                }.frame(height: 300)
            }
        }.onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                while datas.state == .loading {
                    sleep(1)
                }
                if datas.state == .success {
                    // swiftlint:disable force_try
                    books = try! datas.decodeData(data: datas.jsonData)
                    // swiftlint:enable force_try
                }
            }
        }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.loadingText = localizedString(text: strLoading)
        })
    }
}

struct LibraryBookVertical_Previews: PreviewProvider {
    static var previews: some View {
        LibraryBookVertical()
    }
}
