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
        _loader = StateObject(wrappedValue: Loader(url:"https://uc4afba093ec0fa8d84ea1df33ca.previews.dropboxusercontent.com/p/thumb/ABSfx6mkeyOcgVEP3X1kski5gsIAA0AuEHd-UvZO0JgUz4WKg4wjtB0l6Wr9z20kIA_WN1B9lbcaU2Dqii453gaavdFGJcR3SR0aQ59MSazZ5HK9OYEwQAl_sfVlc5viCHVnJ6MMEcmUWnkxUZox2VPWoMC5sceBJQaIbIQxfpfPSiK8xKF3pzHypPZe7BBg9CeRdgnayWAGSxY2PXSu9tVT6zvl6YahWnSDrno8rglqSIW9vYaH_z2cQp4fjuwYiOuoyvoaNnhVpZBNzjbKbjrSXWeVbAauwAjddTPuvLUAPavWSYfPzHSGfmzLSMWvUZRFc72SvvZZyXKzsh_wpWit27lKZIUAa-qYJQ9X406ieQ/p.png?fv_content=true&size_mode=5"))
        //_datas = StateObject(wrappedValue: DownloadJson(url:"http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/1/chapters"))
    }
    @Environment(\.scenePhase) var scenePhase
    @State var isNavigationBarHidden :Bool = true
    @State var showSplashScreen:Bool=true
    @State var backgroundTime: Date?
    @StateObject public var loader: Loader
    //@StateObject public var datas: DownloadJson
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
    
    //calculate how long the app runs in background
    //Determine whether to display splash screen
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


