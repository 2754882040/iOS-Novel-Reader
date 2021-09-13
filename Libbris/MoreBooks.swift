//
//  MoreBooks.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-09-09.
//

import SwiftUI

struct MoreBooks: View {
    init(){
        _datas = StateObject(wrappedValue: DownloadJson(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=9&size=29"))
    }
    @State var books:[BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    var body: some View {
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
            
            ScrollView(.vertical){
            if(books.count == 0){Text("No More Books").frame(alignment:.center)}
                else{
                    let items = 0...(books.count-1)
                    ForEach(items,id: \.self){item in
                        ZStack(){
                        BookButton(bookDetail:books[item]).padding(.bottom, 15.0);
                        }
                    }
                }
            }
        }
    }
}

struct MoreBooks_Previews: PreviewProvider {
    static var previews: some View {
        MoreBooks()
    }
}

