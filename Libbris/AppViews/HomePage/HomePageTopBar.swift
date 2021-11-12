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
                Image("logo_libbris_white").padding(.leading, 5.0)
            }
        }
    }
}

struct HomePageTopBar_Previews: PreviewProvider {
    static var previews: some View {
        HomePageTopBar()
    }
}
