//
//  ToReadHorizontalView.swift
//  Libbris
//
//  Created by 阿毛 on 2021-08-12.
//

import SwiftUI

struct ToReadHorizontalView: View {
    var body: some View {
        HStack{
            ForEach(0..<1, id: \.self){ _ in
                Spacer(minLength: 15)
                Image("default_cover")
                    .overlay(Image("label_hot").offset(x: 6, y: -32), alignment: .topLeading)
                Spacer(minLength: 36)
                Image("default_cover")
                Spacer(minLength: 36)
                Image("default_cover")
                    .overlay(Image("label_reading").offset(x: -8, y: -1), alignment: .topTrailing)
                Spacer(minLength: 15)
            }.background(Image("blank_book_shadow").offset(x: 0, y: 5))
             
        }.background(Image("bookshelf").offset(x: 0, y: 112), alignment: .bottom)
    }
}

struct ToReadHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        ToReadHorizontalView()
    }
}
