//
//  HorizontalBookList.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct HorizontalBookList: View {
    var body: some View {
        let items = 1...3
        let columns = [GridItem(),GridItem(),GridItem()]
        LazyVGrid(columns: columns)
        {
            ForEach(items,id: \.self)
            {items in
                BookButton();
            }
        }.background(Image("bookshelf").offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: 110))
    }
}

struct HorizontalBookList_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalBookList()
    }
}
