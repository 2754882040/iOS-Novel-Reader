//
//  BookShelfTopBar.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-23.
//

import SwiftUI

struct BookShelfTopBar: View {
    @State var libraryText = localizedString(text: strLibrary)
    @State var searchAreaText = localizedString(text: strSearchArea)
    let screenSize: CGRect = UIScreen.main.bounds
    @State private var searchName: String = ""
    var body: some View {
        ZStack(alignment: .leading) {
            TopBarBackGround()
            VStack {
                Spacer()
                HStack {
                    Text(libraryText)
                        .foregroundColor(.white)
                        .font(.custom("Dosis-Bold", size: 20)).padding(.leading,3.0)
                    searchArea.accessibilityIdentifier("SearchArea")
                    NavigationLink(destination: SearchResults(searchName: searchName)) {
                        Image(systemName: "magnifyingglass").accessibilityIdentifier("SearchButton")
                    }
                }.padding(.bottom, 10.0)            }.frame(width: screenSize.width, height: screenSize.height * 0.1)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.libraryText = localizedString(text: strLibrary)
            self.searchAreaText = localizedString(text: strSearchArea)
        })
    }
    var searchArea: some View {
        TextField(searchAreaText, text: $searchName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .accessibilityIdentifier("SearchField")
    }
}
#if !TESTING
struct BookShelfTopBar_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfTopBar()
    }
}
#endif
