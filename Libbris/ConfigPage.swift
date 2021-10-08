//
//  ConfigPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//

import SwiftUI

struct ConfigPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var settingsText = localizedString(text: strSettings);
    @State var languageSetting = localizedString(text: strLanguageSetting);
    @State var infos = localizedString(text: strInfos);
    @State var applicationSetting = localizedString(text: strApplicationSetting);
    @State var PrivacyAndSafety = localizedString(text: strPrivacyAndSafety);
    @State var textOthers = localizedString(text: strOthers);
    var body: some View {
        NavigationView{
        Form{
            Section(header: Text(applicationSetting).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.custom("Dosis-Bold", size: 20))) {
                NavigationLink(destination: BlankView()){
                    Text("\(applicationSetting) 1").font(.custom("Dosis-Regular", size: 15))
                };
            
                NavigationLink(destination: BlankView()){
                    Text("\(applicationSetting) 2").font(.custom("Dosis-Regular", size: 15))
                };
                NavigationLink(destination: BlankView()){
                    Text("\(applicationSetting) 3").font(.custom("Dosis-Regular", size: 15))
                };
                
            }
            Section(header: Text(PrivacyAndSafety).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.custom("Dosis-Bold", size: 20))) {
                NavigationLink(destination: BlankView()){
                    Text(PrivacyAndSafety).font(.custom("Dosis-Regular", size: 15))
                };
            
                
            }
            Section(header: Text(textOthers).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.custom("Dosis-Bold", size: 20))) {
                NavigationLink(destination: InfoPage()){
                    Text(infos).accessibilityIdentifier("AppInfo").font(.custom("Dosis-Regular", size: 15))
                };
                
                NavigationLink(destination: LanguagePage()){
                    Text(languageSetting).accessibilityIdentifier("languageSetting").font(.custom("Dosis-Regular", size: 15))
                };
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Text(settingsText)
        .foregroundColor(.white).font(.custom("Dosis-Bold", size: 20))
            )
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.languageSetting = localizedString(text: strLanguageSetting)
            self.infos = localizedString(text: strInfos)
            self.settingsText = localizedString(text: strSettings)
            self.applicationSetting = localizedString(text: strApplicationSetting)
            self.PrivacyAndSafety = localizedString(text: strPrivacyAndSafety)
            self.textOthers = localizedString(text: strOthers)
        })
        }
    }
}

struct ConfigPage_Previews: PreviewProvider {
    static var previews: some View {
        ConfigPage()
    }
}
