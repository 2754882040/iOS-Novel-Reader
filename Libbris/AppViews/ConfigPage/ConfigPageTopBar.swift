//
//  ConfigPageTopBar.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-10-23.
//

import SwiftUI

struct ConfigPageTopBar: View {
    @State var settingsText = localizedString(text: strSettings)
    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack(alignment: .leading) {
                TopBarBackGround()
                HStack {
                    Text(settingsText)
                        .foregroundColor(.white)
                        .font(.custom("Dosis-Bold", size: 20)).padding(.leading, 8.0)
                    Spacer()
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
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                    self.settingsText = localizedString(text: strSettings)
                })
        } else {
            // Fallback on earlier versions
        }
    }
}
#if !TESTING
struct ConfigPageTopBar_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPageTopBar()
    }
}
#endif
