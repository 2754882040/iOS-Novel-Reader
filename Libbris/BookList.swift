//
//  BookList.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-15.
//

import SwiftUI

struct BookList: View {
    init(url:String){
        _datas = StateObject(wrappedValue: DownloadJson(url:url))
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var books:[BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    @State var loadingText = localizedString(text: strLoading)
    @State var noBooksText = localizedString(text: strNoMoreBook)
    let screenSize: CGRect = UIScreen.main.bounds
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            ScrollView(.vertical){
                if(books.count == 0){
                    VStack{
                        Text(loadingText).font(.custom("Dosis-Regular", size: 12))
                    }.frame(height: 240, alignment: .center)
                }
                else{
                    let items = 0...(books.count-1)
                    ForEach(items,id: \.self){item in
                        LibraryBook(bookDetail:books[item]).accessibilityIdentifier("LibraryBook\(item)");
                        Spacer(minLength: 20)
                    }
                    Text(noBooksText).accessibilityIdentifier("NoMoreBooksText")
                    Spacer(minLength: 10)
                }
                
            }.frame(width: screenSize.width)
        }.onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
            while(datas.state == .loading){
                sleep(1)
            }
            if datas.state == .success{
                books = try! datas.decodeData(data: datas.jsonData)
                //print(books.count)
            }
            }
        }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.loadingText = localizedString(text: strLoading)
            self.noBooksText = localizedString(text: strNoMoreBook)
        })
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=1&size=9")
    }
}
