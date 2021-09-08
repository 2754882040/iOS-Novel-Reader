//
//  ContentView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI
struct ContentView: View {
    @State private var show:Bool=false
    @State private var selection: Tabs = .home

     private enum Tabs: Hashable {
        case home
        case library
        case setting
         
     }
    var body: some View {

        TabView(selection: $selection) {
            MainView().tabItem {
                if selection == Tabs.home{
                    Image("icon_home_sel_iOS_25@1")
                }else{
                    Image("icon_home_nor_iOS_25@1")
                }
            }.tag(Tabs.home)
            LibraryPage().tabItem {
                if selection == Tabs.library{
                    Image("icon_library_sel_iOS_25@1")
                }else{
                    Image("icon_library_nor_iOS_25@1")
                }
            }.tag(Tabs.library)
            ConfigPage().tabItem {
                if selection == Tabs.setting{
                    Image("icon_settings_sel_iOS_25@1")
                }else{
                    Image("icon_settings_nor_iOS_25@1")
                }
            }.tag(Tabs.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
