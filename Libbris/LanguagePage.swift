//
//  LanguagePage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct LanguagePage: View {
    @Binding var shouldShowLanguagePage:Bool
    @State var englishText = localizedString(text: strEnglish)
    @State var chineseText = localizedString(text: strChinese)
    @State var frenchText = localizedString(text: strFrench)
    var body: some View {
        List{
            Button(action: {showLanguage()} ) {
                Text("123")
            }
            Button(action: {changeLanguage(language: "en")
                NotificationCenter.default.post(name: .switchLanguage, object: nil)
            } ) {
                Text(englishText)
            }
            Button(action: {changeLanguage(language: "fr")
                NotificationCenter.default.post(name: .switchLanguage, object: nil)
            } ) {
                Text(frenchText)
            }
            Button(action: {changeLanguage(language: "zh-Hans")
                NotificationCenter.default.post(name: .switchLanguage, object: nil)
            } ) {
                Text(chineseText)
            }
        }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.englishText = localizedString(text: strEnglish)
            self.chineseText = localizedString(text: strChinese)
            self.frenchText = localizedString(text: strFrench)
        })
    }
}

struct LanguagePage_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePage(shouldShowLanguagePage:.constant(true))
    }
}
