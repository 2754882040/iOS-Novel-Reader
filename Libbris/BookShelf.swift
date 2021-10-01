//
//  BookShelf.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-09.
//

import SwiftUI

struct BookShelf: View {
   
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var recommendText = localizedString(text: strRecommend)
    @State var hotText = localizedString(text: strHot)
    @State var moreText = localizedString(text: strMore)
    @State var libraryText = localizedString(text: strLibrary)
    //@State var searchText = localizedString(text: strSearch)
    var body: some View {
        NavigationView{
                VStack{
                    HStack{
                        Text(recommendText).font(.custom("Dosis-Bold", size: 25)).foregroundColor(.yellow)
                        Spacer()
                    }
                    LibraryBookVertical()
                    HStack{
                        Text(hotText).font(.custom("Dosis-Bold", size: 25)).foregroundColor(.yellow)
                        Spacer()
                        NavigationLink(destination: MoreBooksPage()){
                            HStack{
                                Text("\(moreText)").font(.custom("Dosis-Bold", size: 20))
                                Image(systemName: "arrowtriangle.forward.fill")
                            }
                        }.accessibilityIdentifier("MorePageButton")
                        .padding(.trailing, 10.0)
                    }
                    BookList(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/11?start=1&size=5", cId: 11).navigationViewStyle(StackNavigationViewStyle()).navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline).navigationBarItems(leading: Text(libraryText).foregroundColor(.white).font(.custom("Dosis-Bold", size: 20)),trailing: NavigationLink(destination: SearchPage()){Image(systemName: "magnifyingglass")}.accessibilityIdentifier("Search"))
                    Spacer(minLength: 20)
                }.padding(.leading,10).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                    self.recommendText = localizedString(text: strRecommend)
                    self.hotText = localizedString(text: strHot)
                    self.moreText = localizedString(text: strMore)
                    self.libraryText = localizedString(text: strLibrary)
                    
                })
                
            
        }
    }
}

struct BookShelf_Previews: PreviewProvider {
    static var previews: some View {
        BookShelf()
    }
}
