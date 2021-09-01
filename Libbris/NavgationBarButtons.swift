//
//  NavgationBarButtons.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct NavgationBarButtons: View {
    
    @State var showConfig:Bool = false
    
    var body: some View {
        HStack{Button(action: {print("Edit button pressed...")}) {Image("icon_library_nor").imageScale(.large).accessibilityIdentifier("icon_library_nor_button")};
            Button(action: {
                print("Config button pressed...")
                self.showConfig = true
            }) {
                Image("icon_settings_nor").imageScale(.large).accessibilityIdentifier("ConfigButton")
            };
            NavigationLink(
                destination: ConfigView().navigationBarTitle(Text("Configuration")),
                isActive: $showConfig,
                label: {}
            )
        }
    }
}



struct NavgationBarButtons_Previews: PreviewProvider {
    static var previews: some View {
        NavgationBarButtons()
    }
}
