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
        _loader = StateObject(wrappedValue: Loader(url:"https://uce67a46929e11e1cd30c9f7d909.previews.dropboxusercontent.com/p/thumb/ABTxm9Ptf3B7g2pxy7luelmBgaenKv9nAVH58BZlhUG7tJKK6Z7KRgmn6IigOpenFYr-oiZyiEnjwtyUCjDLOwyYVOuXOcTh9UAV6GRApzbUXHF8vRwc5DfefEXzVeLmO07_xkJSylmbGw5ROU-QvsklwUklK4uSnus3kfViIH0gDndoqWAE9lgsnsREyH6HjnPHN10Fx1AHnuMi1gDeJhdhudtE3YVEtXrZNxK7ntt8hO1_HCCMsAbgtRhV1ubzCyAcUm_pqW0L8vplahO9E4iuqwOrZ8kIO2Ut0-tpLvDSAyrDSzSD2q_BDkjafbs9Xi5FGeUduD7dmKG_8g1xQRpKxQ6NjEWaNTYTzyLc3yezcQ/p.png?fv_content=true&size_mode=5"))
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


