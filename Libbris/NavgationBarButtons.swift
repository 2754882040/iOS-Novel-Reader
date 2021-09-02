//
//  NavgationBarButtons.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-11.
//

import SwiftUI

struct NavgationBarButtons: View {
    @State private var shouldShowConfigPage = false
    @State var configText = localizedString(text: strConfig);
    var bookBtn: some View {
        Button(action: {
                print("Edit button pressed...")
        }) {
            Image("icon_library_nor").imageScale(.large).accessibilityIdentifier("icon_library_nor_button")
        }
    }
    var configPageBtn: some View {
        Button(action: {
            shouldShowConfigPage = true
        }) {
            Image("icon_settings_nor").imageScale(.large).accessibilityIdentifier("ConfigButton")
        }
    }
    var body: some View {
        HStack{
            bookBtn;
            configPageBtn;
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                        self.configText = localizedString(text: strConfig)})
        NavigationLink(destination: ConfigPage(shouldShowConfigPage:$shouldShowConfigPage).navigationBarTitle(Text(configText)),
                       isActive: $shouldShowConfigPage,
                       label:{})
    }
}


<<<<<<< HEAD
=======

>>>>>>> development
struct NavgationBarButtons_Previews: PreviewProvider {
    static var previews: some View {
        NavgationBarButtons()
    }
}
