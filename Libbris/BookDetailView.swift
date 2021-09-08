//
//  BookDetailView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-09.
//

import SwiftUI

struct BookDetailView: View {
    var bookId:Int
    var body: some View {
        Text("book ID:\(bookId)").navigationViewStyle(StackNavigationViewStyle()).navigationBarTitleDisplayMode(.inline)
    }
}
/*
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}*/
