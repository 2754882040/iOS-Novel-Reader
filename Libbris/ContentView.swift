//
//  ContentView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI
struct ContentView: View {
    @State private var show:Bool=false
    
    var body: some View {

        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            MainView().tabItem {
                //Image("icon_home_nor")
                Text("Home")
            }.tag(1)
            ConfigPage().tabItem {
                //Image("icon_setting_nor")
                Text("Setting")
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
