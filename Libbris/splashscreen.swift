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
    @Binding var show:Bool
    var body:some View
    {
        //if(show){
        
            Image("screens/Default-568h").resizable(resizingMode: .stretch).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(perform: countTime)
        
        //}
        
    }
    func countTime()
    {
        //print($show)
        var countDownNum = 2
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if countDownNum == 0 {
                  // 销毁计时器
                timer.invalidate()
                self.mode.wrappedValue.dismiss()
                //show = false
                // countDownNum = 5
                print(">>> Timer has Stopped!")
            } else {
                print(">>> Countdown Number: \(countDownNum)")
                countDownNum -= 1
            }
        }
        // 设置宽容度
        countdownTimer.tolerance = 0.2
        // 添加到当前 RunLoop，mode为默认。
        RunLoop.current.add(countdownTimer, forMode: .default)
        // 开始计时
        countdownTimer.fire()
    }
}

