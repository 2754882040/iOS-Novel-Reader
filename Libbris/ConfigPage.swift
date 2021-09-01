//
//  ConfigPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct ConfigPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var shouldShowConfigPage:Bool
    @State private var shouldShowInfoPage = false
    @State private var shouldShowLanguagePage = false
    @State var languageSetting = localizedString(text: strLanguageSetting);
    @State var infos = localizedString(text: strInfos);
    @State var backText = localizedString(text: strBack);
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text(backText)
                }
            }
        }
    var body: some View {
        List{
            Button(action: {
                GoToSetting()
            }) {
                Text(languageSetting)
            }.accessibilityIdentifier("languageSetting")
            Button(action: {
                shouldShowInfoPage = true
            }) {
                Text(infos)
            }.accessibilityIdentifier("AppInfo")
            Button(action: {
                shouldShowLanguagePage = true
            }) {
                Text(languageSetting)
            }.accessibilityIdentifier("languageSetting")
            
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.languageSetting = localizedString(text: strLanguageSetting)
            self.infos = localizedString(text: strInfos)
            self.backText = localizedString(text: strBack)
        })
        NavigationLink(destination: InfoPage(shouldShowInfoPage:$shouldShowInfoPage),
                       isActive: $shouldShowInfoPage,label:{})
        NavigationLink(destination: LanguagePage(shouldShowLanguagePage:$shouldShowLanguagePage),
                       isActive: $shouldShowLanguagePage,label:{})
        
    }
    func showLanguage(){
        let languagePrefix = Locale.preferredLanguages[0]
        print(languagePrefix)
    }
    func GoToSetting(){
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        //链接：https://juejin.cn/post/6844904132566843406
       
    }
}

struct ConfigPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPage(shouldShowConfigPage:.constant(true))
    }
}
