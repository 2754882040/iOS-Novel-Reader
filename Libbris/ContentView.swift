//
//  ContentView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI

struct ContentView: View {
    @State private var show:Bool=false
    @Binding var showsplash:Bool
    var body: some View {
        //SplashScreen(show: $show)
        NavigationView{
        ZStack{
        Image("bg-wall-ios/Default-568h").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                VStack{
                    ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(width: 200, height: 200)
                                    .background(Color.red)
                            }
                }.navigationTitle("Navigation")
                .navigationBarItems(
                    trailing:
                        NavigationLink(destination: secondView(),label:{Text("second View")}))
            }
            
            
            NavigationLink(destination: secondView(),label:{Text("second View")})
            NavigationLink(destination: SplashScreen(show:$showsplash), isActive: $showsplash) { EmptyView() }
        }
            
        }
                   }
        //Text("Hello, world!").padding()
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showsplash: .constant(false))
    }
}
