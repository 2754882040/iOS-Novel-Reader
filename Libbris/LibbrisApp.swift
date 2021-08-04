//
//  LibbrisApp.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-07-21.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("log-didFinishLaunching")
        return true
    }
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("log-DidReceiveMemoryWarning")
    }
}

@main
struct LibbrisApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
    @State var isNavigationBarHidden :Bool = true
    @State var showSplashScreen:Bool=false
    @State var backgroundTime: Date?
    var body: some Scene {
        WindowGroup {
            /*if showSplashScreen
            {
                SplashScreen(show:$showSplashScreen)
            }
             else{}*/
            NavigationView{
                ZStack{
                ContentView().onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .active:
                        do{
                            print("APP active")
                            splashScreenShow()
                        }
                        
                    case .inactive:
                      print("App inactive")
                    case .background:
                        do {
                            print("App background")
                            setBackgroundRunTime()
                        }
                        
                    @unknown default:
                      print("default")
                    }
                }.navigationBarTitle("Hidden Title")
                .navigationBarHidden(self.isNavigationBarHidden)
                .onAppear {
                    self.isNavigationBarHidden = true
                }
                if showSplashScreen 
                {
                    NavigationLink(destination: SplashScreen(show:$showSplashScreen,time:$backgroundTime), isActive: $showSplashScreen) { EmptyView() }
                }
                
                }}
                    
             }
        
        }
    
    
    func setBackgroundRunTime()
    {
        self.backgroundTime = Date()
    }
    func splashScreenShow()
    {
        let now = Date()
        guard let background = backgroundTime else{return}
        if abs(now.timeIntervalSinceReferenceDate - background.timeIntervalSinceReferenceDate) > 5
        {
            showSplashScreen = true
            print("need to show splash screen")
            
            backgroundTime = Date()        }
        else
        {
            return
        }
    }
}
