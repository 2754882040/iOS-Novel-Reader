//
//  ReadingBookChapters.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-26.
//

import SwiftUI

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

struct ReadingBookChapters: View {
    init(bookId:Int){
        _datas = StateObject(wrappedValue: DownloadJson(url:getAllChaptersAPI(bookId: bookId)))
        self.bookId = bookId

        //let parsedURL = URL(string: getChapterContentAPI(bookId:bookId,chapterId:1))
        //let chaptersURL = URL(string: getAllChaptersAPI(bookId: bookId))
        //bookContentURL = parsedURL!
        //bookChaptersURL = chaptersURL!
        

    }
    
    enum bookDetailLoadingState{
        case loadingChapters,loadingChaptersFailed, loadingContents,loadingConteentsFailed,Success
    }
    @State var loadingState = bookDetailLoadingState.loadingChapters
    @StateObject public var datas: DownloadJson
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var bookChapterId:Int=1
    var bookId:Int
    @State var bookContentURL:URL = URL(string: getChapterContentAPI(bookId:1,chapterId:1))!
    //var bookChaptersURL:URL
    let screenSize: CGRect = UIScreen.main.bounds
    @State var bookChapters:[BookChapter] = [BookChapter]()
    @State var curPage = 0
    @State var pages = [NSAttributedString]()
    @State var testInput = NSMutableAttributedString()
    @State var currentPage:Int = 0
    @State var ChapterContent:String = ""
    
    var reloadButton: some View{
        Button(action: {},label: {Text("Try again")})
        
    }
    var loadingText: some View{
        Text("loading...")
    }
    var bookContent: some View{
        Text("contents")
    }
    var body: some View {
        ZStack{
            Color(white: 1, opacity: 1)
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
                if ( loadingState == bookDetailLoadingState.loadingChapters){
                    loadingText.onAppear(perform: {getChapters()})
                }else if loadingState == bookDetailLoadingState.loadingChaptersFailed ||
                            loadingState == bookDetailLoadingState.loadingConteentsFailed{
                    reloadButton
                }else if loadingState == bookDetailLoadingState.loadingContents{
                    loadingText.onAppear(perform: {loadContentData()})
                }else{
                    if pages.count > 0{
                        MyTextView(text: pages[curPage].mutableCopy() as! NSMutableAttributedString, width: screenSize.width * 0.75).frame(width: screenSize.width * 0.75, height: screenSize.height * 0.75).accessibilityIdentifier("BookContent")}
                }
            }
        HStack{
            Button(action: {curPage -= 1}) {Text("PREVIOUS PAGE")}
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {Text("back")}
            Button(action: {curPage += 1}) {Text("NEXT PAGE")}
            
        }
    }
    func getChapters(){
        DispatchQueue.global(qos: .background).async {
            print("callgetchapter")
            if datas.state == DownloadJson.LoadState.failure{
                self.loadingState = bookDetailLoadingState.loadingChaptersFailed
            }
            else if datas.state == DownloadJson.LoadState.success{
                self.bookChapters = try! JSONDecoder().decode([BookChapter].self, from: datas.jsonData)
                print(self.bookChapters)
                if bookChapters.count > 0 {
                    print("chapter id")
                    print(bookChapterId)
                    bookChapterId = bookChapters[0].id
                    print(bookChapterId)
                }
                self.loadingState = bookDetailLoadingState.loadingContents
            }
            else {
                getChapters()
            }
        }
    }
    func loadContentData(){
        DispatchQueue.global(qos: .background).async {
        print("callloadContentData")
        self.bookContentURL = URL(string: getChapterContentAPI(bookId:bookId,chapterId:bookChapterId))!
        URLSession.shared.dataTask(with: bookContentURL) { data, response, error in
            guard let tempString = NSString(data: data ?? Data(), encoding: String.Encoding.utf8.rawValue) else{
                self.loadingState = bookDetailLoadingState.loadingConteentsFailed
                return}
            print("success")
            ChapterContent = tempString as String
            ChapterContent = ChapterContent.htmlToString
            pages = getContent(content: ChapterContent)
            self.loadingState = bookDetailLoadingState.Success
            
        }.resume()
        }
    }
    
    func getContent(content:String)->[NSAttributedString]{
        self.testInput = NSMutableAttributedString(string: content,attributes: attribute())
        let framesetter = CTFramesetterCreateWithAttributedString(testInput as CFAttributedString)
        let path = CGPath(rect:CGRect(origin: CGPoint.zero, size:CGRect(x: 0, y: 0, width: screenSize.width * 0.75, height: screenSize.height * 0.75).size), transform: nil)
        var range = CFRangeMake(0, 0)
        var rangeOffset = 0
        var rangeArray = [NSRange]()
        repeat{
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, nil)
            range = CTFrameGetVisibleStringRange(frame)
            rangeArray.append(NSMakeRange(rangeOffset, range.length))
            rangeOffset += range.length

        }while(range.location + range.length < testInput.string.count)
        let size = rangeArray.count
        var page = [NSAttributedString]()
       print(size)
        for n in 0..<size {
            let attributedString = testInput.attributedSubstring(from: rangeArray[n])
            page.append(attributedString)
        }
        return page

    }
}
/*
struct ReadingBookChapters_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBookChapters()
    }
}
 */
