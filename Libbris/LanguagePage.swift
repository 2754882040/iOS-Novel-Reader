//
//  LanguagePage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct LanguagePage: View {
    @Binding var shouldShowLanguagePage:Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LanguagePage_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePage(shouldShowLanguagePage:.constant(true))
    }
}
