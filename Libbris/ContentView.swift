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
        NavigationView{
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
