//
//  ConfigPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct ConfigPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var settingsText = localizedString(text: strSettings)
    @State var languageSetting = localizedString(text: strLanguageSetting)
    @State var infos = localizedString(text: strInfos)
    @State var applicationSetting = localizedString(text: strApplicationSetting)
    @State var clearData = localizedString(text: strClearData)
    @State var privacyAndSafety = localizedString(text: strPrivacyAndSafety)
    @State var textOthers = localizedString(text: strOthers)
    var body: some View {
        VStack(spacing: 0) {
            ConfigPageTopBar()
            Form {
                Section(header: Text(applicationSetting)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.custom("Dosis-Bold", size: 20))) {
                    Button(action: {
                        let cachePath = NSHomeDirectory().appending("/Documents")
                        do {
                            try FileManager.default.removeItem(atPath: cachePath)
                        } catch {print("\(#function) not found dir")}
                        do {
                            try FileManager.default
                                .createDirectory(atPath: cachePath,
                                                 withIntermediateDirectories: true)
                        } catch {print("\(#function) not found dir")}
                    }, label: {
                        Text(clearData)
                    }).accessibilityIdentifier("clearData")
                }
                Section(header: Text(privacyAndSafety)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.custom("Dosis-Bold", size: 20))) {
                    NavigationLink(destination: BlankView()) {
                        Text(privacyAndSafety).font(.custom("Dosis-Regular", size: 15))
                    }
                }
                Section(header: Text(textOthers)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .font(.custom("Dosis-Bold", size: 20))) {
                    NavigationLink(destination: InfoPage()) {
                        Text(infos).accessibilityIdentifier("AppInfo")
                            .font(.custom("Dosis-Regular", size: 15))
                    }
                    NavigationLink(destination: LanguagePage()) {
                        Text(languageSetting)
                            .accessibilityIdentifier("languageSetting")
                            .font(.custom("Dosis-Regular", size: 15))
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
                self.languageSetting = localizedString(text: strLanguageSetting)
                self.infos = localizedString(text: strInfos)
                self.settingsText = localizedString(text: strSettings)
                self.applicationSetting = localizedString(text: strApplicationSetting)
                self.clearData = localizedString(text: strClearData)
                self.privacyAndSafety = localizedString(text: strPrivacyAndSafety)
                self.textOthers = localizedString(text: strOthers)
            })
        }
    }
}
#if !TESTING
struct ConfigPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPage()
    }
}
#endif
