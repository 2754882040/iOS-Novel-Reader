//
//  BookshelfView.swift
//  Libbris
//
//  Created by 阿毛 on 2021-08-12.
//

import SwiftUI

struct BookshelfView: View {
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)
        //coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
    }
    
    var body: some View {
        ZStack() {
            Image("bg-wall-ios/Default-568h").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(.all)
                .navigationBarItems(leading: Image("logo_libbris_white"), trailing: HStack(){
                    Image("icon_library_nor")
                    Spacer(minLength: 18)
                    Image("icon_settings_nor")
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                } ).navigationBarTitleDisplayMode(.inline)
            VStack(alignment: .leading){
                OnReadingView()
                ToReadView()
            }
        }
    }
}

struct BookshelfView_Previews: PreviewProvider {
    static var previews: some View {
        BookshelfView()
    }
}
