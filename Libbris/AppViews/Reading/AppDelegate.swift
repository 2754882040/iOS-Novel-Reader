//
//  AppDelegate.swift
//  Libbris
//
//  Created by liming on 2021-11-24.
//


import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let col1 = UIColor(#colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = col1

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 36, weight: .black)
        ]

        appearance.largeTitleTextAttributes = attrs
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        return true
    }

}
