//
//  InfoPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//
import Foundation
import SwiftUI

struct InfoPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var teamText = localizedString(text: strTeam)
    @State var versionText = localizedString(text: strVersion)
    @State var mailText = localizedString(text: strMail)
    @State var infos = localizedString(text: strInfos);
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.backward").foregroundColor(.white)
                    Text(infos).foregroundColor(.white).font(.custom("Dosis-Bold", size: 20))
                }
            }
        }
    var body: some View {
        VStack(alignment: .center){
            Image(uiImage: UIImage(imageLiteralResourceName: "AppIcon"))
                .resizable(resizingMode: .stretch)
                .frame(width: 100.0, height: 100.0)
                .accessibilityIdentifier("iconImage")
                .padding(/*@START_MENU_TOKEN@*/.all, 30.0/*@END_MENU_TOKEN@*/)
            List{
                Text("\(versionText): \(Bundle.main.appVersionShort!)")
                Text("""
                    \(teamText)
                    Liming Yang
                    Peiyang Wang
                    Rouwen Mao
                    Yukuan Hao
                    """).accessibilityIdentifier("teamInfo")
                Text("\(mailText): info.libbris.com")
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")), perform: { _ in
            self.infos = localizedString(text: strInfos)
            self.teamText = localizedString(text: strTeam)
            self.versionText = localizedString(text: strVersion)
            self.mailText = localizedString(text: strMail)
        })
        
    }
}


extension Bundle {
    
    public var appVersionShort: String? {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    
}
