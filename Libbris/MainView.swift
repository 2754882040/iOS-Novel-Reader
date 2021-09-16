//
//  MainView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct MainView: View {
    init() {
        _datas = StateObject(wrappedValue: DownloadJson(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/16?start=1&size=20"))
        UINavigationBar.appearance().backgroundColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        UINavigationBar.appearance().barTintColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
    }
    @State var books:[BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    var body: some View {
        NavigationView{
        ZStack{
            Image("wall").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(perform: {
                DispatchQueue.global(qos: .background).async {
                while(datas.state == .loading){
                    sleep(1)
                }
                if datas.state == .success{
                    books = try! datas.decodeData(data: datas.jsonData)
                    print(books.count)
                }
                }
            })
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
                                    BookButton(bookDetail:books[item]).padding(.bottom, 15.0).accessibilityIdentifier("BookButton\(item)");
                                }
                            }
                        }
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline).navigationBarItems(leading:Image("logo_libbris_white").imageScale(.large))
        .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
