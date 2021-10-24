//
//  BookDetailView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-09.
//

import SwiftUI
struct MyTextView: UIViewRepresentable {
    var text: NSMutableAttributedString
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<MyTextView>) {
        uiView.attributedText = text
    }
    var width: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.attributedText = text
        return label
    }
}
func attribute()->[NSAttributedString.Key:Any]{
    let font = UIFont.systemFont(ofSize: 10)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.firstLineHeadIndent = 5.0
    paragraphStyle.lineSpacing = 5
    paragraphStyle.paragraphSpacing = 10
    paragraphStyle.lineBreakMode = .byWordWrapping
    return [.font: font, .paragraphStyle: paragraphStyle]
}

struct BookDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var bookChapterId:Int
    var bookId:Int
    var bookContentURL:URL
    let screenSize: CGRect = UIScreen.main.bounds
    
    @State var pages = [NSAttributedString]()
    @State var testInput = NSMutableAttributedString()
    @State var currentPage:Int = 0
    @State var ChapterContent:String = ""
    
    var body: some View {
        ZStack{
            Color(white: 1, opacity: 1)
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
                .onAppear(perform:{
                    URLSession.shared.dataTask(with: bookContentURL) { data, response, error in
                        let tempString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        print("success")
                        ChapterContent = tempString! as String
                        pages = getContent(content: ChapterContent)
                        
                    }.resume()
                })
            if pages.count > 0{
                MyTextView(text: pages[0] as! NSMutableAttributedString, width: screenSize.width * 0.75).frame(width: screenSize.width * 0.75, height: screenSize.height * 0.75).accessibilityIdentifier("BookContent")}
               
            }
        Button(action: {self.presentationMode.wrappedValue.dismiss()}) {Text("back")}
        }
    
    init(bookId:Int, bookChapterId:Int = 1){
        self.bookId = bookId
        self.bookChapterId = bookChapterId
        guard let parsedURL = URL(string: getChapterContentAPI(bookId:bookId,chapterId:bookChapterId)) else {
            fatalError("Invalid URL: \(getChapterContentAPI(bookId:bookId,chapterId:bookChapterId))")
        }
        bookContentURL = parsedURL
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
       
        for n in 0..<size {
            let attributedString = testInput.attributedSubstring(from: rangeArray[n])
            page.append(attributedString)
        }
        return page

    }
}
/*
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}*/
