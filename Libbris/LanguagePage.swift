//
//  LanguagePage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct LanguagePage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var englishText = localizedString(text: strEnglish)
    @State var chineseText = localizedString(text: strChinese)
    @State var frenchText = localizedString(text: strFrench)
    //@State var backText = localizedString(text: strBack);
    @State var languageSetting = localizedString(text: strLanguageSetting);
    var languages = [localizedString(text: strEnglish), localizedString(text: strChinese), localizedString(text: strFrench)]
    @State private var selectedLanguage:Int = getLanguageNumber()
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
            HStack{
                    Image(systemName: "arrow.backward").foregroundColor(.white).frame(alignment: .leading)
                Text(languageSetting).foregroundColor(.white).font(.custom("Dosis-Bold", size: 20)).frame(alignment: .leading)
                    Spacer()
                }.frame(alignment: .leading)
            Spacer()
            }
        }
    var body: some View {
        Picker(languageSetting, selection: $selectedLanguage) {
               ForEach(0 ..< languages.count) {
                Text(self.languages[$0]).accessibilityIdentifier("\(self.languages[$0])")               }
        }.accessibilityIdentifier("picker") .onChange(of: selectedLanguage, perform: { selectedLanguage in
            changeLanguage(languageCode: selectedLanguage)
            NotificationCenter.default.post(name: .switchLanguage, object: nil)
        }).navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.englishText = localizedString(text: strEnglish)
            self.chineseText = localizedString(text: strChinese)
            self.frenchText = localizedString(text: strFrench)
            self.languageSetting = localizedString(text: strLanguageSetting)
        })
    }
}

struct LanguagePage_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePage()//shouldShowLanguagePage:.constant(true))
    }
}
