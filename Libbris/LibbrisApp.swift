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
        _loader = StateObject(wrappedValue: Loader(url:"https://uc7d11632bec8f9c2152ea0b08b0.previews.dropboxusercontent.com/p/thumb/ABVpptBOCyhwPWDJsN0rkmZVUKraLHI7dhSH8a2C8KSVMp9TmbLU3zDtmSsv-WVx5v9bpmGUsB49wlsztrmkxm3iKQSNmXOVBJtu-t3G8SBtup8UMHb_O_Gzp7McI5R6xA2QG3Bodg2dtwHCaVzyK_M0V5hKSn36Jx0RW06LpcdRULhi4H7xQQ0bpd6KaOu9mb5lGfls77f_HAiwLBe3PvZblBRgbWHvSHf3K7gs-SREewDYPP85n8h7D4ACEF-nq3Qswo5QIdNvMfKmVNmi9vgkEsJ5ONvekv9mMCWcs-JqQDXS3isSZosq7f_XS6GQyWE4HJer0fVf3Q9kCvj-2X8qZ_ESdQY7V4AXv7DbIKObyQ/p.png?fv_content=true&size_mode=5"))
    }
    @Environment(\.scenePhase) var scenePhase
    @State var isNavigationBarHidden :Bool = true
    @State var showSplashScreen:Bool=true
    @State var backgroundTime: Date?
    @StateObject public var loader: Loader
    var lastUpdateDate = Date()
    var body: some Scene {
        WindowGroup {
            
                ZStack{
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
                    }.navigationBarHidden(self.isNavigationBarHidden).onAppear {
                        self.isNavigationBarHidden = true
                    }
                    if showSplashScreen{
                        SplashScreen(showSplashScreen:$showSplashScreen,backgroundRuningTime:$backgroundTime)
                    }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func setBackgroundRunTime(){
        self.backgroundTime = Date()
    }

    func splashScreenControl(){
        let now = Date()
        guard let background = backgroundTime else{return}
        if abs(now.timeIntervalSinceReferenceDate - background.timeIntervalSinceReferenceDate) > 5 {
            showSplashScreen = true
            print("need to show splash screen")
            backgroundTime = Date()
        }
    }
}


