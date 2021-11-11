//
//  LibbrisApp.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI

@main
struct LibbrisApp: App {
    init() {
        // swiftlint:disable line_length
        _loader = StateObject(wrappedValue: Loader(url: "https://ucb11545093654e5f8b5bda1402d.previews.dropboxusercontent.com/p/thumb/ABWs-4goiQs0WT4QZwfdZaC-So27PqwET60Ywe4_p-U_dxLv_qLWrG4ohEXkHKMDlyfWS3l3Ws9IJkbo-vC8xBr96eUFOfGGi2SBWFtmYBpXAOnCXZNxmR19TSrpOrU8WA7TdI6YtVSmljb9be780lCGlIUqCZHaqgLZTuYaonFJC4FvkIB016i52D2ntxAi0zIgGziycmJA43D5Oo3re_XLhm6euInFwcHG6fJXH5w3dG1IjiVW85DqFpGOB78pBWE4WEvLBxvNuM7Z0Hv2x5yDGTz432YXNyuh3EO5qH3c5UGF139aHmaEIxnv4cxjqw91GtKJmL5wihcb58ZOJpOJE2S-EQXj0u_QtpQAGZUGo2ZyQ2NL5RjwBrECs87hLwM/p.png", name: "Ads"))
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
                                            "https://ucb11545093654e5f8b5bda1402d.previews.dropboxusercontent.com/p/thumb/ABWs-4goiQs0WT4QZwfdZaC-So27PqwET60Ywe4_p-U_dxLv_qLWrG4ohEXkHKMDlyfWS3l3Ws9IJkbo-vC8xBr96eUFOfGGi2SBWFtmYBpXAOnCXZNxmR19TSrpOrU8WA7TdI6YtVSmljb9be780lCGlIUqCZHaqgLZTuYaonFJC4FvkIB016i52D2ntxAi0zIgGziycmJA43D5Oo3re_XLhm6euInFwcHG6fJXH5w3dG1IjiVW85DqFpGOB78pBWE4WEvLBxvNuM7Z0Hv2x5yDGTz432YXNyuh3EO5qH3c5UGF139aHmaEIxnv4cxjqw91GtKJmL5wihcb58ZOJpOJE2S-EQXj0u_QtpQAGZUGo2ZyQ2NL5RjwBrECs87hLwM/p.png", interval: 5)
            // swiftlint:enable line_length
            print("need to show splash screen")
            backgroundTime = Date()
        }
    }
}
