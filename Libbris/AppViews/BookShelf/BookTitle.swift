//
//  BookTitle.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-11.
//

import SwiftUI

struct BookTitle: View {
    init(title: String) {
        self.title = title
    }
    let title: String
    var body: some View {
        Text("\(title)")
            .lineLimit(1)
            .foregroundColor(.black)
            .font(.custom("Dosis-Bold", size: 17))
    }
}
#if !TESTING
struct BookTitle_Previews: PreviewProvider {
    static var previews: some View {
        BookTitle(title: "asadas")
    }
}
#endif
