//
//  SearchResults.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-11-08.
//

import SwiftUI

struct SearchResults: View {
    init(searchName: String) {
        self.search = searchName
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var libraryText = localizedString(text: strLibrary)
    @State var noMoreBookText = localizedString(text: strNoMoreBook)
    let search: String

    var body: some View {
            ZStack {
                Image("wall").resizable(resizingMode:
                .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    BookList(url: searchAPI(name: search)).accessibilityIdentifier("SearchResultsPage")
                    }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                self.noMoreBookText = localizedString(text: strNoMoreBook)
                self.libraryText = localizedString(text: strLibrary)
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true).navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.backward").foregroundColor(.white)
                        Text(libraryText).foregroundColor(.white).font(.custom("Dosis-Bold", size: 20))
                    }
                })
            .navigationViewStyle(StackNavigationViewStyle())
    }
}
