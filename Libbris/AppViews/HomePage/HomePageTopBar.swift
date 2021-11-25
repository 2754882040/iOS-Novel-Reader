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
        if #available(iOS 15.0, *) {
            ZStack(alignment: .leading) {
                TopBarBackGround()
                VStack {
                    Image("logo_libbris_white").padding(.leading, 5.0)
                }
            }.overlay(alignment: .top, content: {
                TopBarBackGround() // Or any view or color
                    .background(.regularMaterial)
                // I put clear here because I prefer to put a blur in this case.
                // This modifier and the material it contains are optional.
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 0)
                // This will constrain the overlay to only go above the top safe area and not under.
            })
        } else {
            // Fallback on earlier versions
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
