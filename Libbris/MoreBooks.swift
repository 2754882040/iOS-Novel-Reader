//
//  MoreBooks.swift
//  Libbris
//
//  Created by 王沛洋 on 2021-09-09.
//

import SwiftUI

struct MoreBooks: View {
    @State var range: Range<Int> = 0..<6
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing: 50){
                ForEach(range) {_ in
                    HorizontalBookList();
                }
            }
            Spacer(minLength: 30)
            Text("No more books")
    }
}

struct MoreBooks_Previews: PreviewProvider {
    static var previews: some View {
        MoreBooks()
    }
}
}
