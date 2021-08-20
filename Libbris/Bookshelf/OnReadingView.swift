//
//  OnReadingView.swift
//  Libbris
//
//  Created by 阿毛 on 2021-08-12.
//

import SwiftUI

struct OnReadingView: View {
    var body: some View {
        
        ScrollView(.horizontal){
            VStack(alignment: .leading){
                Text("ON READING").padding()
                HStack(spacing: 12){
                    ForEach(0..<6, id: \.self){ _ in
                        Spacer()
                        Image("default_cover")
                    }
                    .background(Image("blank_book_shadow").offset(x: 0, y: 5), alignment: .center)
                    .overlay(Image("label_hot").offset(x: 6, y: -32), alignment: .topLeading)
                    .overlay(Image("label_reading").offset(x: -8, y: -1), alignment: .topTrailing)
                }.padding()
            }
           
        }.background(Image("bookshelf").offset(x: 0, y: 95), alignment: .bottom).accessibility(identifier: "bookshelf")
        
    }
}

struct OnReadingView_Previews: PreviewProvider {
    static var previews: some View {
        OnReadingView()
    }
}
