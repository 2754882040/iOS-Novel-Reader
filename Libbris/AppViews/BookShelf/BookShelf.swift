//
//  BookShelf.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-09.
//

import SwiftUI

struct BookShelf: View {
    // @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var recommendText = localizedString(text: strRecommend)
    @State var hotText = localizedString(text: strHot)
    @State var moreText = localizedString(text: strMore)
    var body: some View {
        VStack {
            BookShelfTopBar()
            VStack {
                HStack {
                    Text(recommendText).font(.custom("Dosis-Bold", size: 25)).foregroundColor(.yellow)
                    Spacer()
                }
                LibraryBookVertical()
                HStack {
                    Text(hotText).font(.custom("Dosis-Bold", size: 25)).foregroundColor(.yellow)
                    Spacer()
                    NavigationLink(destination: MoreBooksPage()) {
                        HStack {
                            Text("\(moreText)").font(.custom("Dosis-Bold", size: 20))
                            Image(systemName: "arrowtriangle.forward.fill")
                        }
                    }
                    .accessibilityIdentifier("MorePageButton")
                    .padding(.trailing, 10.0)
                }
                BookList(url: getBookByCategoryAPI(categoryId: 11, start: 1, size: 5), cId: 11)
                Spacer(minLength: 20)
            }.padding(.leading, 10)
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")),
                           perform: { _ in
                    self.recommendText = localizedString(text: strRecommend)
                    self.hotText = localizedString(text: strHot)
                    self.moreText = localizedString(text: strMore)
                })
        }
    }
}
#if !TESTING
struct BookShelf_Previews: PreviewProvider {
    static var previews: some View {
        BookShelf()
    }
}
#endif
