//
//  BookButton.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct BookButton: View {
    public enum LoadState {
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
            selectImage().resizable().padding(.top, 13.0).padding(.bottom, 22.0).background(Image("blank_book_shadow")).frame(width: 90, height: 160, alignment: .bottom)//.overlay(Text(bookDetail.name))
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
struct BookButton_Previews: PreviewProvider {
    static var previews: some View {
        BookButton()
    }
}*/

