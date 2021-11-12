//
//  BookButton.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

class ImageLoader: ObservableObject {
    init(url: String) {
        refresh(url: url)
    }
    var data = Data()
    var state = LoadState.loading
    func refresh(url: String) {
        state = LoadState.loading
        let urlWithoutSpace: String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "badlink"
        guard let parsedURL = URL(string: urlWithoutSpace)
        else {
           fatalError("Invalid URL: \(url)")
        }
        URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
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

struct HomeBookButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var loader: ImageLoader
    @State var bookCover = Image("default_cover")
    var loading: Image
    var failure: Image
    init(bookDetail: BookInfoBriefWithTime,
         loading: Image = Image("default_cover"),
         failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: bookDetail.cover ?? "badlink"))
        self.loading = loading
        self.failure = failure
        self.bookDetail = bookDetail
    }
    var bookDetail: BookInfoBriefWithTime
    var body: some View {
        NavigationLink(destination: ReadingBookChapters(bookId: bookDetail.id)) {
            bookCover.resizable().padding(.top, 13.0).padding(.bottom, 22.0)
                .background(Image("blank_book_shadow")).frame(width: 90, height: 160, alignment: .bottom)
        }
        .onAppear(perform: {
            DispatchQueue.global(qos: .background).async {
                loader.refresh(url: bookDetail.cover ?? "badlink")
                while loader.state != .success {
                    sleep(1)
                }
                bookCover = selectImage()
            }
        })
        .accessibilityIdentifier("HomeBookButton\(bookDetail.id)")
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
struct BookButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeBookButton(bookDetail: <#BookInfoBriefWithTime#>)
    }
}*/
