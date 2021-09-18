//
//  MoreBooksPage.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-09-13.
//

import SwiftUI

public enum Tabs: Hashable {
   case hot
   case recommend
   case new
    
}

struct MoreBooksPage: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var searchName: String = ""
    @State var libraryText = localizedString(text: strLibrary)
    @State var noMoreBookText = localizedString(text: strNoMoreBook)
    @State var selection: Tabs = .hot

    var body: some View {
            ZStack{
                Image("wall").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    TabBarView(tabIndex: $selection)
                    
                TabView(selection: $selection) {
                    BookList(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=1&size=9").tag(Tabs.hot).accessibilityIdentifier("HotPage")
                    BookList(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/12?start=1&size=9").tag(Tabs.recommend).accessibilityIdentifier("RecPage")
                    BookList(url: "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/13?start=1&size=9").tag(Tabs.new).accessibilityIdentifier("NewPage")
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.noMoreBookText = localizedString(text: strNoMoreBook)
            self.libraryText = localizedString(text: strLibrary)
        }).navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true).navigationBarItems(leading:Button(action: {
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

struct MoreBooksPage_Previews: PreviewProvider {
    static var previews: some View {
        MoreBooksPage()
    }
}

