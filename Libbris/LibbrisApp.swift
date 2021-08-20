//
//  LibbrisApp.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI

/*class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("log-didFinishLaunching")
        return true
    }
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("log-DidReceiveMemoryWarning")
    }
}*/

@main
struct LibbrisApp: App {
    init() {
        _loader = StateObject(wrappedValue: Loader(url:"https://media.idownloadblog.com/wp-content/uploads/2018/08/iPhone-XS-marketing-wallpaper-768x1663.jpg"))
    }
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    @State var isNavigationBarHidden :Bool = true
    @State var showSplashScreen:Bool=true
    @State var backgroundTime: Date?
    @StateObject public var loader: Loader
    var lastUpdateDate = Date()
    var body: some Scene {
        WindowGroup {
            NavigationView{
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
                    }.navigationBarTitle("Hidden Title").navigationBarHidden(self.isNavigationBarHidden).onAppear {
                        self.isNavigationBarHidden = true
                    }
                    if showSplashScreen{
                        NavigationLink(destination: SplashScreen(showSplashScreen:$showSplashScreen,backgroundRuningTime:$backgroundTime),
                                       isActive: $showSplashScreen) { EmptyView()}
                    }
                    
                }
                
            }
            
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
