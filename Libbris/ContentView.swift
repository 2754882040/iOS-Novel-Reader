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
            BlankView()
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BlankView: View {
    var body: some View {
        VStack{
            ZStack{
                Image("bg-wall-ios/Default-568h").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Text("Hello, world!")
            }
        }
    }
}
