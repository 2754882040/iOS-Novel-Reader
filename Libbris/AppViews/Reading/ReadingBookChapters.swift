//
//  ReadingBookChapters.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-26.
//

import UIKit
import SwiftUI
struct MyTextView: UIViewRepresentable {
    var text: NSAttributedString
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
func attribute(fontSize: CGFloat, textColor: UIColor)->[NSAttributedString.Key: Any] {
    let font = UIFont.systemFont(ofSize: fontSize)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    paragraphStyle.firstLineHeadIndent = 5.0
    paragraphStyle.lineSpacing = 5
    paragraphStyle.paragraphSpacing = 10
    paragraphStyle.lineBreakMode = .byWordWrapping
    return [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: textColor]
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                        .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

enum BookDetailLoadingState {
    case loadingChapters, loadingChaptersFailed, loadingContents, loadingConteentsFailed, successAllLoading, changeFont
}

struct ReadingBookChapters: View {
    init(bookId: Int) {
        _datas = StateObject(wrappedValue: DownloadJson(url: getAllChaptersAPI(bookId: bookId)))
        _lastReadManager = StateObject(wrappedValue: ReadingSettingsManager(bookId))
        self.bookId = bookId
        _chapterId = State(initialValue: 0)
        _bgColor = State(initialValue: colorDict[UserDefaults.standard.integer(forKey: "bgColor")] ?? .white)
        _textFontSize = State(initialValue: fontDict[UserDefaults.standard.integer(forKey: "fontSize")] ?? 15.0)
        _textColor = State(initialValue: textColorDict[UserDefaults.standard.integer(forKey: "fontColor")] ?? UIColor.darkText)
        _nightMode =  State(initialValue: UserDefaults.standard.bool(forKey: "nightMode"))
        _loadLastReadPosition = State(initialValue: true)
    }
    init(bookId: Int, bookChapterId: Int) {
        _datas = StateObject(wrappedValue: DownloadJson(url: getAllChaptersAPI(bookId: bookId)))
        _lastReadManager = StateObject(wrappedValue: ReadingSettingsManager(bookId))
        self.bookId = bookId
        _chapterId = State(initialValue: bookChapterId)
        _bgColor = State(initialValue: colorDict[UserDefaults.standard.integer(forKey: "bgColor")] ?? .white)
        _textFontSize = State(initialValue: fontDict[UserDefaults.standard.integer(forKey: "fontSize")] ?? 15.0)
        _textColor = State(initialValue: textColorDict[UserDefaults.standard.integer(forKey: "fontColor")] ?? UIColor.darkText)
        _nightMode =  State(initialValue: UserDefaults.standard.bool(forKey: "nightMode"))
        _loadLastReadPosition = State(initialValue: false)
    }
    enum ActiveAlert {
        case first, second, third
    }
    @State var bookChapterId: Int = 1
    var bookId: Int
    @State var bookContentURL: URL = URL(string: getChapterContentAPI(bookId: 1, chapterId: 1))!
    let screenSize: CGRect = UIScreen.main.bounds
    @State var bookChapters: [BookChapter] = [BookChapter]()
    @State var loadLastReadPosition: Bool
    @State var curPage = 0
    @State var pages = [NSAttributedString]()
    @State var chapterContentNSMutable = NSMutableAttributedString()
    @State var chapterContent: String = ""
    @State var chapterId: Int
    //    @State var preChapterId: Int = 0
    @State var width: CGFloat = UIScreen.main.bounds.width
    @State var starLocation: CGFloat = 0
    @State var endLocation: CGFloat = 0
    @State var location = CGPoint(x: 0, y: 0)
    @State var textColor: UIColor
    @State var bgColor: UIColor
    @State var textFontSize: CGFloat
    @State var showMenu: Bool = false
    @State private var showAlert = false
    @State var loadingState = BookDetailLoadingState.loadingChapters
    @StateObject public var datas: DownloadJson
    @StateObject public var lastReadManager: ReadingSettingsManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var testInput = NSMutableAttributedString()
    @State private var activeAlert: ActiveAlert = .first
    @State private var showSetting = false
    @State private var navBarHidden = true
    @State var nightMode: Bool
    @State var preChapter: Bool = false
    var reloadButton: some View {
        Button(action: {}, label: {Text("Try again")})
    }
    var loadingText: some View {
        Text("loading...")
    }
    var bookContent: some View {
        Text("contents")
    }
    var pageNumber: some View {
        Text("\(curPage+1) / \(pages.count)")
    }
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    Color(bgColor)
                        .navigationViewStyle(StackNavigationViewStyle())
                        .navigationBarHidden(true)
                        if loadingState == BookDetailLoadingState.loadingChapters {
                            loadingText.onAppear(perform: {getChapters()})
                        } else if loadingState == BookDetailLoadingState.loadingChaptersFailed ||
                                    loadingState == BookDetailLoadingState.loadingConteentsFailed {
                            reloadButton
                        } else if loadingState == BookDetailLoadingState.loadingContents ||
                                    loadingState == BookDetailLoadingState.changeFont {
                            loadingText.onAppear(perform: {loadContentData()})
                        } else {
                            if pages.count > 0 {
                                VStack {
                                    Spacer()
                                HStack {
                                    Spacer()
                                    MyTextView(text: pages[curPage],
                                       width: screenSize.width * 0.75)
                                        .frame(width: screenSize.width * 0.75,
                                               height: screenSize.height * 0.75)
                                        .accessibilityIdentifier("BookContent")
                                    Spacer()
                                }
                                    pageNumber.accessibilityIdentifier("pageNumber")
                                    Spacer()
                                }
                                .onTouch(type: .started, perform: getLocation)
                                .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                               .onEnded { value in
                                                   let horizontalAmount = value.translation.width as CGFloat
                                                   let verticalAmount = value.translation.height as CGFloat
                                   if abs(horizontalAmount) > abs(verticalAmount) {
                                       horizontalAmount < 0 ? turnNextPages() : turnPreviousPages()
                                                   } else {
                                                       print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                                   }
                               })
                                .simultaneousGesture(TapGesture().onEnded(tapToChangePage))
                                .alert(isPresented: $showAlert) {
                                    switch activeAlert {
                                    case .first:
                                        return Alert(title: Text("This is the first page"),
                                                     dismissButton: .default(Text("OK")))
                                    case .second:
                                        return Alert(title: Text("This is the last page"),
                                                     dismissButton: .default(Text("OK")))
                                    case .third:
                                        return Alert(title: Text("Want to exist?"),
                                                     primaryButton: .destructive(Text("Exist"),
                                                                                 action: {
                                            self.presentationMode.wrappedValue.dismiss()}),
                                                     secondaryButton: .default(Text("Cancel"), action: {}))
                                    }
                                }}
                        }
                }
                if showSetting == true {
                    VStack {
                        Text(" ")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Back") {
                                        self.activeAlert = .third
                                        self.showAlert = true
                                    }
                                }
                            }
                        Spacer()
                        ReadingBottomBar(nightMode: $nightMode, bgColor: $bgColor,
                                         textColor: $textColor,
                                         textFontSize: $textFontSize,
                                         loadState: $loadingState)
                    }
                }
            }.navigationBarTitle("")
             .navigationBarHidden(navBarHidden)
             .navigationBarTitleDisplayMode(.inline).ignoresSafeArea(.all)
        }.navigationBarHidden(navBarHidden)
    }
    func turnPreviousPages() {
        if curPage < 1 && chapterId >= 1 {
            chapterId -= 1
            preChapter = true
            loadingState = BookDetailLoadingState.loadingChapters
        } else if curPage > 0 {
            curPage -= 1
            lastReadManager.percent.percent = Double(curPage) / Double(pages.count)
            lastReadManager.percent.chapterId = chapterId
            _ = lastReadManager.saveData()
        } else { self.activeAlert = .first
            self.showAlert = true
        }
    }
    func turnNextPages() {
        if curPage >= pages.count-1 {
            preChapter = false
            if chapterId < bookChapters.count - 1 {
                chapterId += 1
                loadingState = BookDetailLoadingState.loadingChapters
                curPage = 0
                lastReadManager.percent.percent = Double(curPage) / Double(pages.count)
                lastReadManager.percent.chapterId = chapterId
                _ = lastReadManager.saveData()
            } else {
                    self.activeAlert = .second
                    self.showAlert = true
                }
        } else if curPage < pages.count && chapterId < bookChapters.count {
            curPage += 1
            lastReadManager.percent.percent = Double(curPage) / Double(pages.count)
            lastReadManager.percent.chapterId = chapterId
            _ = lastReadManager.saveData()
        } else { self.activeAlert = .second
            self.showAlert = true }
    }
    func getLocation(_ location: CGPoint) {
        self.location = location
    }

    func tapToChangePage() {
        print(width)
        if location.x < width/3 {
            turnPreviousPages()
        } else if location.x > 2*width/3 {
            turnNextPages()
        } else {
            showSetting.toggle()
            navBarHidden.toggle()
            print(navBarHidden)
        }
    }
    func getChapters() {
        DispatchQueue.global(qos: .background).async {
            if datas.state == DownloadJson.LoadState.failure {
                self.loadingState = BookDetailLoadingState.loadingChaptersFailed
            } else if datas.state == DownloadJson.LoadState.success {
                // swiftlint:disable force_try
                self.bookChapters = try! JSONDecoder().decode([BookChapter].self, from: datas.jsonData)
                // swiftlint:enable force_try
                print(self.bookChapters)
                if bookChapters.count > 0 {
                    bookChapterId = bookChapters[chapterId].id
                }
                self.loadingState = BookDetailLoadingState.loadingContents
            } else {
                getChapters()
            }
        }
    }
    func loadContentData() {
        DispatchQueue.global(qos: .background).async {
            if loadLastReadPosition {
                while lastReadManager.state == .loading {}
                chapterId = lastReadManager.percent.chapterId
            }
            if self.loadingState == .changeFont {
                    let percent = Double(curPage) / Double(pages.count)
                    pages = getContent(content: chapterContent)
                    curPage = Int(Double(pages.count) * percent)
                self.loadingState = BookDetailLoadingState.successAllLoading
                return
            } else {
                self.bookContentURL = URL(string: getChapterContentAPI(bookId: bookId, chapterId: bookChapterId))!
                URLSession.shared.dataTask(with: bookContentURL) { data, _, _ in
                    guard let tempString = NSString(data: data ?? Data(),
                                                    encoding: String.Encoding.utf8.rawValue) else {
                        self.loadingState = BookDetailLoadingState.loadingConteentsFailed
                        return}
                    print("success")
                    chapterContent = tempString as String
                    chapterContent = chapterContent.htmlToString
                    if pages.count != 0 {
                        if preChapter {
                            preChapter = false
                            pages = getContent(content: chapterContent)
                            curPage = pages.count - 1
                            lastReadManager.percent.percent = Double(curPage) / Double(pages.count)
                            lastReadManager.percent.chapterId = chapterId
                            _ = lastReadManager.saveData()
                        } else {
                            let percent = Double(curPage) / Double(pages.count)
                            pages = getContent(content: chapterContent)
                            curPage = Int(Double(pages.count) * percent)
                        }
                    } else {
                        pages = getContent(content: chapterContent)
                            if loadLastReadPosition {
                                while lastReadManager.state == .loading {}
                                curPage = Int(Double(pages.count) * lastReadManager.percent.percent)
                                loadLastReadPosition = false
                            }
                        }
                    self.loadingState = BookDetailLoadingState.successAllLoading
                }.resume()
            }
        }
    }
    func getContent(content: String) -> [NSAttributedString] {
        self.chapterContentNSMutable = NSMutableAttributedString(string: content,
                                                                 attributes: attribute(fontSize: textFontSize,
                                                                                       textColor: textColor))
        let framesetter = CTFramesetterCreateWithAttributedString(chapterContentNSMutable as CFAttributedString)
        let path = CGPath(rect:
                            CGRect(origin: CGPoint.zero,
                                   size: CGRect(x: 0, y: 0,
                                               width: screenSize.width * 0.75,
                                               height: screenSize.height * 0.75).size), transform: nil)
        var range = CFRangeMake(0, 0)
        var rangeOffset = 0
        var rangeArray = [NSRange]()
        repeat {
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, nil)
            range = CTFrameGetVisibleStringRange(frame)
            rangeArray.append(NSMakeRange(rangeOffset, range.length))
            rangeOffset += range.length

        }while(range.location + range.length < chapterContentNSMutable.string.count)
        let size = rangeArray.count
        var page = [NSAttributedString]()
       print(size)
        for num in 0..<size {
            let attributedString = chapterContentNSMutable.attributedSubstring(from: rangeArray[num])
            page.append(attributedString)
        }
        return page

    }
}

#if !TESTING
struct ReadingBookChapters_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBookChapters(bookId: 77)
    }
}
#endif
