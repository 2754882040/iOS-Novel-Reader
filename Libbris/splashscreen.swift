//
//  splashscreen.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-03.
//

import Foundation
import SwiftUI

struct SplashScreen:View {
    @Environment(\.presentationMode) var mode
    @Binding var showSplashScreen:Bool
    @Binding var backgroundRuningTime:Date?
    var body:some View
    {
        Image("screens/Default-568h").resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(perform: countTime).navigationBarBackButtonHidden(true)
    }
    /*
     create a timer, after finish count, pop current view and set binding variable 'time' to nil
     */
    func countTime()
    {
        var countDownNum = 2
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if countDownNum == 0 {
                timer.invalidate()
                self.mode.wrappedValue.dismiss()
                backgroundRuningTime = nil
                print(">>> Timer has Stopped!")
            } else {
                print(">>> Countdown Number: \(countDownNum)")
                countDownNum -= 1
            }
        }
        countdownTimer.tolerance = 0.2
        RunLoop.current.add(countdownTimer, forMode: .default)
        countdownTimer.fire()
    }
}

