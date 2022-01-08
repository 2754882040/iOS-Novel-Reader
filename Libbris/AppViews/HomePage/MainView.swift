//
//  MainView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct MainView: View {
    init() {
        // _datas = StateObject(wrappedValue: DownloadJson(url:fullPath))
        UINavigationBar.appearance().backgroundColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        UINavigationBar.appearance().barTintColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var books: [BookInfoBriefWithTime] = [BookInfoBriefWithTime]()
    @State var emptyText = localizedString(text: strEmpty)
    @StateObject public var localJsonFile: LocalJsonFileManager = LocalJsonFileManager.shared
    fileprivate func refreshBook() {
        DispatchQueue.global(qos: .background).async {
            localJsonFile.sortArray()
            books = localJsonFile.bookShelfBook
        }
    }
    var body: some View {
        ZStack {
            Image("wall")
                .resizable(resizingMode: .stretch)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onAppear(perform: {
                    localJsonFile.readData()
                    DispatchQueue.global(qos: .background).async {
                        while localJsonFile.state == .loading {
                            // sleep(1)
                        }
                        if localJsonFile.state == .success {
                            print("test main view loading books")
                            books = localJsonFile.bookShelfBook
                            print(books.count)
                        } else {books = [BookInfoBriefWithTime]() }
                    }
            }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("refreshBook")), perform: { _ in
                refreshBook()})
            VStack(alignment: .leading, spacing: 10) {
                HomePageTopBar()
                ScrollView(.vertical) {
                    if books.count == 0 {
                        Text(emptyText).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).padding()
                    } else {
                        let items = 0...(books.count-1)
                        let columns = [GridItem(), GridItem(), GridItem()]
                        LazyVGrid(columns: columns) {
                            ForEach(items, id: \.self) { item in
                                ZStack {
                                    if item % 3 == 0 {
                                        Image("bookshelf")
                                            .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: 85)
                                    }
                                    HomeBookButton(bookDetail: books[item])
                                        .padding(.bottom, 15.0)
                                }
                            }
                        }
                    }
                }.accessibilityIdentifier("HomePageScrollView")
                Spacer(minLength: 0)
                TopBarBackGround()
            }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                self.emptyText = localizedString(text: strEmpty)
            })
        }.ignoresSafeArea(.all)
    }
}
#if !TESTING
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
