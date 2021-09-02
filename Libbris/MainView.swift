//
//  MainView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct MainView: View {
    init() {
        UINavigationBar.appearance().backgroundColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        UINavigationBar.appearance().barTintColor =
            #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
    }
    var body: some View {
        ZStack{
            Image("wall").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading)
            {
                BookListHorizontal()
                BookListVertical()
            }
        }.navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:Image("logo_libbris_white").imageScale(.large),trailing: NavgationBarButtons())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
