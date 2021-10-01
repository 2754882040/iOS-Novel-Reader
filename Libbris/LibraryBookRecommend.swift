//
//  LibraryBookRecommend.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-14.
//

import SwiftUI

struct LibraryBookRecommend: View {
    private enum LoadState {
    case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            let urlWithoutSpace:String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "badlink"
            guard let parsedURL = URL(string: urlWithoutSpace) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var localJsonFile: localJsonFileManager = localJsonFileManager.shared
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    //let fullPath = NSHomeDirectory().appending("/Documents/").appending("bookShelf.json")
    init(bookDetail: BookInfoBrief, loading: Image = Image("default_cover"), failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: Loader(url: bookDetail.cover ?? "badlink" ))
        self.loading = loading
        self.failure = failure
        self.bookDetail = bookDetail
    }
    var bookDetail:BookInfoBrief
    var body: some View {

        NavigationLink(destination: BookDetailView(bookId:bookDetail.id)){
            
            HStack(alignment: .top){
                selectImage().resizable().frame(width: 100, height: 150, alignment: .bottom)
                VStack(alignment: .leading, spacing: 1.0){
                    Text("\(bookDetail.name)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Bold", size: 17))
                    Text("\(bookDetail.authorName)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                    Text("\(bookDetail.summary)").lineLimit(3).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                    
                }.frame(width:120)
            }
            
        }.contextMenu(menuItems: {
            Button("add to bookshelf"){
                var tempData: BookInfoBriefWithTime = BookInfoBriefWithTime()
                tempData.id = bookDetail.id
                tempData.authorName = bookDetail.authorName
                tempData.bookUrlName = bookDetail.bookUrlName
                tempData.cover = bookDetail.cover
                tempData.time = Date()
                tempData.name = bookDetail.name
                tempData.summary = bookDetail.summary
                let tempVar = localJsonFile.findBookId(id: tempData.id)
                if(tempVar >= 0){
                    print("already in bookshelf")
                    localJsonFile.bookShelfBook[tempVar].time = Date()
                }else{
                    localJsonFile.bookShelfBook += [tempData]
                }
                localJsonFile.sortArray()
                localJsonFile.saveData(data: localJsonFile.encodeData(data: localJsonFile.bookShelfBook))
                NotificationCenter.default.post(name: .refreshBook, object: nil)
            }
        })
    }
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}
/*
struct LibraryBookRecommend_Previews: PreviewProvider {
    static var previews: some View {
        LibraryBookRecommend()
    }
}*/
