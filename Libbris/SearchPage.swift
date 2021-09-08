//
//  SearchPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-14.
//

import SwiftUI

struct SearchPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchName: String = ""
    @State var libraryText = localizedString(text: strLibrary)
    @State var submitText = localizedString(text: strSubmit)
    @State var searchAreaText = localizedString(text: strSearchArea)
    var searchArea: some View{
        TextField(searchAreaText, text: $searchName).textFieldStyle(RoundedBorderTextFieldStyle())
    }
    var body: some View {
        VStack(){
        HStack(){
            searchArea.padding(.leading, 20.0)
            Button(submitText) {}
                .padding(.trailing, 20.0)
        }.navigationBarBackButtonHidden(true).navigationBarItems(leading:Button(action: {self.presentationMode.wrappedValue.dismiss()}){Text(libraryText)})
        .navigationViewStyle(StackNavigationViewStyle())
        Spacer()
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.submitText = localizedString(text: strSubmit)
            self.libraryText = localizedString(text: strLibrary)
            self.searchAreaText = localizedString(text: strSearchArea)
        })
        
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
