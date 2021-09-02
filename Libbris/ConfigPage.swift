//
//  ConfigPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct ConfigPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var configText = localizedString(text: strConfig);
    @State var languageSetting = localizedString(text: strLanguageSetting);
    @State var infos = localizedString(text: strInfos);
    var body: some View {
        NavigationView{
        List{
            NavigationLink(destination: InfoPage()){
                Text(infos).accessibilityIdentifier("AppInfo")
            };
            
            NavigationLink(destination: LanguagePage()){
                Text(languageSetting).accessibilityIdentifier("languageSetting")
            };
            
        }.navigationViewStyle(StackNavigationViewStyle()).navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline).navigationTitle(configText)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.languageSetting = localizedString(text: strLanguageSetting)
            self.infos = localizedString(text: strInfos)
            self.configText = localizedString(text: strConfig)
        })
            
        }
    }
}

struct ConfigPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPage()//shouldShowConfigPage:.constant(true))
    }
}
