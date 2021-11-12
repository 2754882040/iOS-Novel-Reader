//
//  BookCoverImg.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-11.
//

import SwiftUI

struct BookCoverImg: View {
    init(url: String, width: CGFloat, height: CGFloat,
         alignment: Alignment, loading: Image = Image("default_cover"), failure: Image = Image("default_cover")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.loading = loading
        self.failure = failure
        self.imgWid = width
        self.imgHei = height
        self.imgAlignment = alignment
    }
    @StateObject private var loader: ImageLoader
    var imgWid: CGFloat
    var imgHei: CGFloat
    var imgAlignment: Alignment
    var loading: Image
    var failure: Image
    var body: some View {
        selectImage().resizable().frame(width: imgWid, height: imgHei, alignment: imgAlignment)
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
#if !TESTING
struct BookCoverImg_Previews: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable line_length
        BookCoverImg(url: "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg", width: 100, height: 150, alignment: .bottom)
        // swiftlint:enable line_length
    }
}
#endif
