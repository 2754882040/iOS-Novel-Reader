//
//  BookAuthor.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-11.
//

import SwiftUI

struct BookAuthor: View {
    init(author: String) {
        self.author = author
    }
    let author: String
    var body: some View {
        Text("\(author)")
            .lineLimit(1)
            .foregroundColor(.black)
            .font(.custom("Dosis-Regular", size: 12))
    }
}
#if !TESTING
struct BookAuthor_Previews: PreviewProvider {
    static var previews: some View {
        BookAuthor(author: "adasdasf")
    }
}
#endif
