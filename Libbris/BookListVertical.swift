//
//  BookListVertical.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct BookListVertical: View {
    var body: some View {
        Text("TO READ").padding(.leading)
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing: 50){
                ForEach(0..<7) {_ in
                    HorizontalBookList();
                }
            }
        }
    }
}

struct BookListVertical_Previews: PreviewProvider {
    static var previews: some View {
        BookListVertical()
    }
}
