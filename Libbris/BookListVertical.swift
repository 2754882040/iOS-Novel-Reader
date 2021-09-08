//
//  BookListVertical.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct BookListVertical: View {
    @State var stringLiteral: String = localizedString(text: strToRead);
    
    var body: some View {
        Text(stringLiteral).padding(.leading)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                                                            self.stringLiteral = localizedString(text: strToRead)})
        ScrollView(.vertical){
            VStack(alignment:.leading, spacing: 50){
                ForEach(0..<3) {_ in
                    HorizontalBookList();
                }
                
                Button(action:{} ){
                    Text("More")
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
