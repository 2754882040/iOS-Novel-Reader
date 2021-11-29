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
        ZStack(alignment: .leading) {
            TopBarBackGround()
            HStack {
                Text(settingsText)
                    .foregroundColor(.white)
                    .font(.custom("Dosis-Bold", size: 20)).padding(.leading, 8.0)
                Spacer()
            }
        }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")),
                       perform: { _ in
                self.settingsText = localizedString(text: strSettings)
            })
    }
}
#if !TESTING
struct ConfigPageTopBar_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPageTopBar()
    }
}
#endif
