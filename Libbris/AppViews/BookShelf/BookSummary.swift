//
//  BookSummary.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-11.
//

import SwiftUI

struct BookSummary: View {
    init(summary: String) {
        self.summary = summary
    }
    let summary: String
    var body: some View {
        Text("\(summary)")
            .lineLimit(3)
            .foregroundColor(.black)
            .font(.custom("Dosis-Regular", size: 12))
    }
}
#if !TESTING
struct BookSummary_Previews: PreviewProvider {
    static var previews: some View {
        BookSummary(summary: "babala")
    }
}
#endif
