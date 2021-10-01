//
//  BookList.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-15.
//

import SwiftUI

struct BookList: View {
    init(url:String,cId:Int){
        _datas = StateObject(wrappedValue: DownloadJson(url:url))
        self.categoryId = cId
        self.url = url
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var books:[BookInfoBrief] = [BookInfoBrief]()
    @StateObject public var datas: DownloadJson
    @State var loadingText = localizedString(text: strLoading)
    @State var noBooksText = localizedString(text: strNoMoreBook)
    @State var noMoreBook: Bool = false
    @State var curBookCount: Int = 0
    let url:String
    let categoryId:Int
    let screenSize: CGRect = UIScreen.main.bounds
    var loadMore: some View {
        Text("loading")
    }
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
                    LazyVStack{
                        ForEach(items,id: \.self){item in
                            LibraryBook(bookDetail:books[item]).accessibilityIdentifier("LibraryBook\(item)");
                            Spacer(minLength: 20)
                        }
                        if noMoreBook {Text(noBooksText).accessibilityIdentifier("NoMoreBooksText")}
                        else{loadMore.onAppear(perform: {loadBook()})}
                        Spacer(minLength: 10)
                        
                    }
                }
                
            }.frame(width: screenSize.width)
           
        }.onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
            while(datas.state == .loading){
                sleep(1)
            }
            if datas.state == .success{
                let temp:[BookInfoBrief] = try! datas.decodeData(data: datas.jsonData)
                if !temp.isEmpty {
                    books += temp
                }
                curBookCount = books.count
            }
            }
        }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.loadingText = localizedString(text: strLoading)
            self.noBooksText = localizedString(text: strNoMoreBook)
        })
    }
    func loadBook(){
        curBookCount = books.count
        datas.getData(URLString: getBookByCategoryAPI(categoryId: categoryId, start: curBookCount+1, size: 20))
        print("loading book")
        DispatchQueue.global(qos: .background).async {
            while(datas.state == .loading){
                sleep(1)
                print("sleep")
            }
            if datas.state == .success{
                books += try! datas.decodeData(data: datas.jsonData)
                if curBookCount != books.count{
                    curBookCount = books.count
                }else{
                    noMoreBook = true
                    print(books.count)
                }
            }else{
                //lastBookCount = curBookCount
            }
        }
    }
}

/*struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        BookList(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=1&size=9")
    }
}*/
