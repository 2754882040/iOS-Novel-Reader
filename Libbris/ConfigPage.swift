//
//  ConfigPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct ConfigPage: View {
    @Binding var shouldShowConfigPage:Bool
    @State private var shouldShowInfoPage = false
    @State private var shouldShowLanguagePage = false
    var body: some View {
        List{
            Button(action: {
                GoToSetting()
            }) {
                Text("change Language")
            }.accessibilityIdentifier("languageSetting")
            Button(action: {
                shouldShowInfoPage = true
                showLanguage()
            }) {
                Text("Information")
            }.accessibilityIdentifier("AppInfo")
            
        }
        NavigationLink(destination: InfoPage(shouldShowInfoPage:$shouldShowInfoPage),
                       isActive: $shouldShowInfoPage) { EmptyView()}
        NavigationLink(destination: LanguagePage(shouldShowLanguagePage:$shouldShowLanguagePage),
                       isActive: $shouldShowLanguagePage) { EmptyView()}
        
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
