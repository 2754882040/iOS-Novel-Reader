//
//  splashscreen.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-08-03.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @Environment(\.presentationMode) var mode
    @Binding var showSplashScreen: Bool
    @Binding var backgroundRuningTime: Date?
    @State var showAD: Bool = false
    @State var ADExist: Bool = false
    let imageDir = "/Documents/Ads"
    var body:some View {
        ZStack {
            Image("screens/Default-568h")
                .resizable(resizingMode: .stretch)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onAppear(perform: countTime)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true).onAppear(perform: countADTime)
                .onAppear(perform: checkAdFile)
            if showAD {
                if ADExist {
                    Image(uiImage: UIImage(contentsOfFile: NSHomeDirectory().appending(imageDir))!)
                        .resizable(resizingMode: .stretch)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .accessibilityIdentifier("ADImage")
                }
            Button(action: {goBackToPreviousView()},
                   label: {
                ZStack {
                    Color.gray
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 70,
                               maxWidth: 80, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                               idealHeight: 30, maxHeight: 30,
                               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    let skipmessage = localizedString(text: strSkip)
                    Text(skipmessage).foregroundColor(.white)
                    }.cornerRadius(20)
            })
            .position(x: 330, y: 30.0).accessibilityIdentifier("skipButton")
            }
        }
    }
    func checkAdFile() {
        ADExist = false
        DispatchQueue.global(qos: .background).async {
            while ADExist != true {
                do {
                    _ = try FileManager.default.attributesOfItem(atPath: NSHomeDirectory().appending(imageDir))
                    ADExist = true
                    showAD = true
                } catch { ADExist = false }
            }
        }
    }
    func countTime() {
        #if !TESTING
        var countDownNum = 5
        #endif
        #if TESTING
        var countDownNum = 3
        #endif
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if countDownNum <= 0 {
                timer.invalidate()
                self.mode.wrappedValue.dismiss()
                showSplashScreen = false
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
    func countADTime() {
        var countDownNum = 1
        let countdownTimer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if countDownNum == 0 {
                timer.invalidate()
                showAD = true
            } else {
                countDownNum -= 1
            }
        }
        countdownTimer.tolerance = 0.2
        RunLoop.current.add(countdownTimer, forMode: .default)
        countdownTimer.fire()
    }
    func goBackToPreviousView() {
        self.mode.wrappedValue.dismiss()
        showSplashScreen = false
        backgroundRuningTime = nil
    }
}
#if !TESTING
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(showSplashScreen: .constant(true), backgroundRuningTime: .constant(Date()))
    }
}
#endif
