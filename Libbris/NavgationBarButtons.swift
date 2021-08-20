//
//  NavgationBarButtons.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct NavgationBarButtons: View {
    var body: some View {
        HStack{Button(action: {print("Edit button pressed...")}) {Image("icon_library_nor").imageScale(.large).accessibilityIdentifier("icon_library_nor_button")};
            Button(action: {
                print("Edit button pressed...")
            }) {
                Image("icon_settings_nor").imageScale(.large)
            };
        }
    }
}

struct NavgationBarButtons_Previews: PreviewProvider {
    static var previews: some View {
        NavgationBarButtons()
    }
}
