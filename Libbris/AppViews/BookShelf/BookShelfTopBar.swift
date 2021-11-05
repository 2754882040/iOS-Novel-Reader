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
    @State private var searchName: String = ""
    var body: some View {
        ZStack(alignment: .leading){
            TopBarBackGround()
            HStack{
                Text(libraryText)
                .foregroundColor(.white)
                    .font(.custom("Dosis-Bold", size: 20)).padding(.leading, 8.0)
                searchArea
                Button(action: {}, label: {Image(systemName: "magnifyingglass")})
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.libraryText = localizedString(text: strLibrary)
            self.searchAreaText = localizedString(text: strSearchArea)
        })
    }
    var searchArea: some View{
        TextField(searchAreaText, text: $searchName).textFieldStyle(RoundedBorderTextFieldStyle()).accessibilityIdentifier("SearchField")
    }
}

struct BookShelfTopBar_Previews: PreviewProvider {
    static var previews: some View {
        BookShelfTopBar()
    }
}
