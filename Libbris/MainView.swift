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
            UIColor.blue
        UINavigationBar.appearance().barTintColor = .blue
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
        .navigationBarItems(leading:Image("logo_libbris_white").imageScale(.large),trailing: NavgationBarButtons()
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
