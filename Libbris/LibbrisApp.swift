//
//  LibbrisApp.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI

@main
struct LibbrisApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        // swiftlint:disable line_length
        _loader = StateObject(wrappedValue: Loader(url: "https://ucdfaaa4b96c503becd236be5959.previews.dropboxusercontent.com/p/thumb/ABUZ5AbrIjWT8zllvOwDNxXTrI43Fcw_ocSx-kvIpOWeMSRHOtQOlqw_nQBGAXfxfWByWssBHtLffhsszqw2zaZsZcUCEgYEZQN6OGs8CAZGpZ9UDiCaTil_qEX2BtrW3uqulqpCD-Wy2j_gc3RVWi3_365QhNsd_YANm98cGwmbhpJwhcovsmZfiZS3qcgte_2Je7mRuOcOuNUFLNyD4_bylqq3WC5vI9AKm1PqQJSMPAjWW4lzeLpu-rwHdg8rurSmyiV2OS2Pg-vey-73HFUphIKMsPX3sS5SoUJm0qzj1-e7kzTkTJqbeTa6yrGVHFA4Ow6w5SSxZU3QUcIie6sjQl_0WQoxabKJkz_icjoL9NrocO68k88vGC36ZwTJycQ/p.png", name: "Ads"))
        // swiftlint:enable line_length
    }
    @Environment(\.scenePhase) var scenePhase
    @State var showSplashScreen: Bool=true
    @State var backgroundTime: Date?
    @StateObject public var loader: Loader
    var lastUpdateDate = Date()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView().onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .active:
                        print("APP active")
                        splashScreenControl()
                    case .inactive:
                        print("App inactive")
                    case .background:
                        print("App background")
                        setBackgroundRunTime()
                    @unknown default:
                        print("default")
                    }
                }
                if showSplashScreen {
                    SplashScreen(showSplashScreen: $showSplashScreen, backgroundRuningTime: $backgroundTime)
                }
            }
        }
    }
    func setBackgroundRunTime() {
        self.backgroundTime = Date()
    }
    func splashScreenControl() {
        let now = Date()
        guard let background = backgroundTime else {return}
        if abs(now.timeIntervalSinceReferenceDate - background.timeIntervalSinceReferenceDate) > 5 {
            showSplashScreen = true
            let fullPath = NSHomeDirectory().appending("/Documents/").appending("Ads")
            // swiftlint:disable line_length
            loader.imageLoadingController(filePath: fullPath,
                                          name: "Ads", URLString:
                                            "https://ucdfaaa4b96c503becd236be5959.previews.dropboxusercontent.com/p/thumb/ABUZ5AbrIjWT8zllvOwDNxXTrI43Fcw_ocSx-kvIpOWeMSRHOtQOlqw_nQBGAXfxfWByWssBHtLffhsszqw2zaZsZcUCEgYEZQN6OGs8CAZGpZ9UDiCaTil_qEX2BtrW3uqulqpCD-Wy2j_gc3RVWi3_365QhNsd_YANm98cGwmbhpJwhcovsmZfiZS3qcgte_2Je7mRuOcOuNUFLNyD4_bylqq3WC5vI9AKm1PqQJSMPAjWW4lzeLpu-rwHdg8rurSmyiV2OS2Pg-vey-73HFUphIKMsPX3sS5SoUJm0qzj1-e7kzTkTJqbeTa6yrGVHFA4Ow6w5SSxZU3QUcIie6sjQl_0WQoxabKJkz_icjoL9NrocO68k88vGC36ZwTJycQ/p.png", interval: 5)
            // swiftlint:enable line_length
            print("need to show splash screen")
            backgroundTime = Date()
        }
    }
}
