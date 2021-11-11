//
//  SwiftUIView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-23.
//

import SwiftUI

struct TopBarBackGround: View {
    let screenSize: CGRect = UIScreen.main.bounds
    var body: some View {
        Color(#colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)).frame(width: screenSize.width, height: screenSize.height * 0.06)
    }
}
#if !TESTING
struct TopBarBackGround_Previews: PreviewProvider {
    static var previews: some View {
        TopBarBackGround()
    }
}
#endif
