//
//  LibraryBook.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-10.
//

import SwiftUI

struct LibraryBook: View {
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
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    init(bookDetail: BookInfoBrief, loading: Image = Image("default_cover"), failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: Loader(url: bookDetail.cover ?? "badlink"))
        self.loading = loading
        self.failure = failure
        self.bookDetail = bookDetail
    }
    var bookDetail:BookInfoBrief
    var body: some View {
        NavigationLink(destination: BookDetailView(bookId:bookDetail.id)){
            HStack(alignment: .top){
                selectImage().resizable().frame(width: 90, height: 120, alignment: .bottom)
                VStack(alignment: .leading, spacing: 3.0){
                    Text("\(bookDetail.name)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Bold", size: 17))//.font(.system(size: 20, weight: .light, design: .default))
                    Text("\(bookDetail.summary)").lineLimit(3).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                    Spacer(minLength: 25)
                    Text("\(bookDetail.authorName)").lineLimit(1).foregroundColor(.black).font(.custom("Dosis-Regular", size: 12))
                }
                Spacer()
            }
        }
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
struct LibraryBook_Previews: PreviewProvider {
    static var previews: some View {
        BookButton(bookDetail: <#BookInfoBrief#>)
    }
}*/
