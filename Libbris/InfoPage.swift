//
//  InfoPage.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-23.
//
import Foundation
import SwiftUI

struct InfoPage: View {
    
    @Binding var shouldShowInfoPage:Bool
    var body: some View {
        //Text("Hello, World!12312313")
        VStack(alignment: .center){
            Image(uiImage: UIImage(imageLiteralResourceName: "AppIcon"))
                .resizable(resizingMode: .stretch)
                .frame(width: 100.0, height: 100.0)
                .accessibilityIdentifier("iconImage")
            List{
                Text("Version: \(Bundle.main.appVersionShort!)")
                Text("""
                    Team
                    Liming Yang
                    Peiyang Wang
                    Rouwen Mao
                    Yukuan Hao
                    """).accessibilityIdentifier("teamInfo")
                Text("mail: info.libbris.com")
            }
        }
        
        
    }
    
}

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage(shouldShowInfoPage:.constant(true))
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
    public var appVersionLong: String? {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appName: String? {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    
}
