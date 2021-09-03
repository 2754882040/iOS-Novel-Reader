//
//  BookListHorizontal.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct BookListHorizontal: View {
    @State var stringLiteral: String = localizedString(text: strOnReading);
    
    var body: some View {
        Text(stringLiteral).padding(.leading).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.stringLiteral = localizedString(text: strOnReading)
        })
        
        ScrollView(.horizontal)
        {
            HStack(alignment:.top, spacing: 40) {
                ForEach(0..<10) {_ in
                    BookButton();
                }
            }
        }.offset(x: 20, y: -10).background(Image("bookshelf").offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: 100))
    }
    
}


struct BookListHorizontal_Previews: PreviewProvider {
    static var previews: some View {
        BookListHorizontal()
    }
}
