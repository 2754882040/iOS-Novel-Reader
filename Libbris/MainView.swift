//
//  MainView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct MainView: View {
    init() {

        //_datas = StateObject(wrappedValue: DownloadJson(url:fullPath))
        UINavigationBar.appearance().backgroundColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        UINavigationBar.appearance().barTintColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        
    }
    @State var books:[BookInfoBriefWithTime] = [BookInfoBriefWithTime]()
    //@StateObject public var datas: DownloadJson
    @StateObject public var localJsonFile: localJsonFileManager = localJsonFileManager.shared
    var body: some View {
        NavigationView{
        ZStack{
            Image("wall").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(perform: {
                localJsonFile.readData()
                DispatchQueue.global(qos: .background).async {
                while(localJsonFile.state == .loading){
                    //sleep(1)
                }
                if localJsonFile.state == .success{
                    print("test main view loading books")
                    books = localJsonFile.bookShelfBook
                    print(books.count)
                }
                }
            }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("refreshBook")), perform: { _ in
                DispatchQueue.global(qos: .background).async {
                    localJsonFile.sortArray()
                    books = localJsonFile.bookShelfBook
                }})
            VStack(alignment: .leading, spacing: 10)
            {
                ScrollView(.vertical){
                    if(books.count == 0){}
                    else{
                        let items = 0...(books.count-1)
                        let columns = [GridItem(),GridItem(),GridItem()]
                        LazyVGrid(columns: columns)
                        {
                            ForEach(items,id: \.self)
                            {item in
                                ZStack{
                                    if(item % 3 == 0){
                                        Image("bookshelf").offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: 85)                }
                                    HomeBookButton(bookDetail:books[item]).padding(.bottom, 15.0)
                                }
                            }
                        }
                    }
                }.accessibilityIdentifier("HomePageScrollView")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:Image("logo_libbris_white").imageScale(.large))
        .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
