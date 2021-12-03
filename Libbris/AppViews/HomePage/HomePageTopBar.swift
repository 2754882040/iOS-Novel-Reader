//
//  HomePageTopBar.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-23.
//

import SwiftUI

struct HomePageTopBar: View {
    let screenSize: CGRect = UIScreen.main.bounds
    var body: some View {
        ZStack(alignment: .leading) {
            TopBarBackGround()
            VStack {
                Spacer()
                HStack {
                    Image("logo_libbris_white").padding([.leading, .bottom], 10.0)
                    Spacer()
                }
            }.frame(width: screenSize.width, height: screenSize.height * 0.1)
        }
    }
}

#if !TESTING
struct HomePageTopBar_Previews: PreviewProvider {
    static var previews: some View {
        HomePageTopBar()
    }
}
#endif
