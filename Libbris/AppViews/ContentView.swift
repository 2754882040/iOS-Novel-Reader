//
//  ContentView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI
struct ContentView: View {
    @State private var show: Bool=false
    @State private var selection: Tabs = .home
     private enum Tabs: Hashable {
        case home
        case library
        case setting
     }
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                MainView().navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true).tabItem {
                    if selection == Tabs.home {
                        Image("icon_home_20210913_sel@25")
                    } else {
                        Image("icon_home_20210913_nor@25")
                    }
                }.tag(Tabs.home)
                BookShelf().navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true).tabItem {
                    if selection == Tabs.library {
                        Image("icon_home_sel_iOS_25@1")
                    } else {
                        Image("icon_home_nor_iOS_25@1")
                    }
                }.tag(Tabs.library)
                ConfigPage().navigationBarTitle("")
                    .navigationBarTitle("")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true).tabItem {
                    if selection == Tabs.setting {
                        Image("icon_settings_sel_iOS_25@1")
                    } else {
                        Image("icon_settings_nor_iOS_25@1")
                    }
                }.tag(Tabs.setting)
            }.navigationBarTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
    }
}
#if !TESTING
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
