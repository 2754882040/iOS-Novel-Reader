//
//  BookButton.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct BookButton: View {
    var body: some View {
        Button(action: {
        }) {
            ZStack{
                //Image("label_hot").offset(x:-30, y: -80)
                //Image("blank_book_shadow").imageScale(.large)
                Image("default_cover").overlay(Image("label_reading").offset(x:30,y:-55)).background(Image("blank_book_shadow").background(Image("label_hot").offset(x:-20,y:-80))).frame(width: 90, height: 160, alignment: .bottom)
                //Image("label_reading").offset(x:30, y: -55)
                //let jsonURL = "https://resource.libbris.com/illustration/1/220px-AlicesAdventuresInWonderlandTitlePage.jpg"
                //RemoteImage(url: jsonURL,loading: Image("default_cover"),failure: Image("default_cover")).frame(width: 90, height: 135, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Item")
            }
        }
    }
}

struct BookButton_Previews: PreviewProvider {
    static var previews: some View {
        BookButton()
    }
}
