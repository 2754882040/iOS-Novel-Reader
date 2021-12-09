//
//  ReadingBottomBar.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-11-17.
//

import SwiftUI

struct ReadingBottomBar: View {
    let screenSize: CGRect = UIScreen.main.bounds
    let percent: CGFloat = 0.07
    @Binding var nightMode: Bool
    @Binding var bgColor: UIColor
    @Binding var textColor: UIColor
    @Binding var textFontSize: CGFloat
    @Binding var loadState: BookDetailLoadingState
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
            ZStack {
                Color(UIColor(#colorLiteral(red: 0.1607843137, green: 0.2745098039, blue: 0.5529411765, alpha: 1)))
                    .frame(width: screenSize.width,
                           height: screenSize.height * 0.05,
                           alignment: .bottom)
                    .disabled(true)
                    .ignoresSafeArea(.all)
                    .opacity(1)
                VStack {
                    HStack {
                        fontControl
                        nightModeControl
                        bgControl
                    }.frame(width: screenSize.width,
                            height: screenSize.height * 0.05,
                            alignment: .bottom)
                    Spacer()
                }.frame(width: screenSize.width,
                        height: screenSize.height * 0.05,
                        alignment: .bottom)
            }.frame(width: screenSize.width,
                    height: screenSize.height * 0.05,
                    alignment: .bottom).ignoresSafeArea(.all)
        }

    var nightModeControl: some View {
        Button(action: {print("nightmodechanged")
            nightMode.toggle()
            nightModeChangeColor()},
               label: { if !nightMode {
                   Image(systemName: "sun.max.fill").resizable()
                       .frame(width: screenSize.width * percent,
                              height: screenSize.width * percent,
                              alignment: .center).foregroundColor(.yellow)
               } else {
                   Image(systemName: "moon.stars.fill").resizable()
                       .frame(width: screenSize.width * percent,
                              height: screenSize.width * percent,
                              alignment: .center).foregroundColor(.yellow)
               }}).accessibilityIdentifier("nightModeController")
    }
    func nightModeChangeColor() {
        if nightMode {
            bgColor = UIColor.darkGray
            textColor = UIColor.lightText
            textFontSize = textFontSize
            UserDefaults.standard.set(4, forKey: "bgColor")
            UserDefaults.standard.set(true, forKey: "nightMode")
            UserDefaults.standard.set(1, forKey: "fontColor")
            loadState = .loadingContents
        } else {
            textColor = UIColor.darkText
            bgColor = UIColor.white
            UserDefaults.standard.set(0, forKey: "bgColor")
            UserDefaults.standard.set(false, forKey: "nightMode")
            UserDefaults.standard.set(0, forKey: "fontColor")
            textFontSize = textFontSize
            loadState = .loadingContents
        }
    }
    var fontControlBtnSmall: some View {
        Button(action: {textFontSize = 15.0
            UserDefaults.standard.set(0, forKey: "fontSize")
            loadState = .changeFont
        },
               label: { Text("A").font(.system(size: 15.0))}).accessibilityIdentifier("fontSmall")
    }
    var fontControlBtnMid: some View {
        Button(action: {textFontSize = 25.0
            UserDefaults.standard.set(1, forKey: "fontSize")
            loadState = .changeFont
        },
               label: { Text("A").font(.system(size: 25.0))}).accessibilityIdentifier("fontMid")
    }
    var fontControlBtnBig: some View {
        Button(action: {textFontSize = 35.0
            UserDefaults.standard.set(2, forKey: "fontSize")
            loadState = .changeFont
        },
               label: { Text("A").font(.system(size: 35.0))}).accessibilityIdentifier("fontLarge")
    }
    var fontControl: some View {
        HStack {
                    Spacer()
                    fontControlBtnSmall
                    Spacer()
                    fontControlBtnMid
                    Spacer()
                    fontControlBtnBig
                    Spacer()
        }
    }
    var bgColorOne: some View {
        Button(action: {bgColor = UIColor.lightGray
            UserDefaults.standard.set(1, forKey: "bgColor")
        },
               label: {
            Color(UIColor.lightGray)
                .frame(width: screenSize.width * percent,
                       height: screenSize.width * percent,
                       alignment: .center)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        })
    }
    var bgColorTwo: some View {
        Button(action: {bgColor = UIColor.systemYellow
            UserDefaults.standard.set(2, forKey: "bgColor")
        },
               label: {
            Color(UIColor.systemYellow)
                .frame(width: screenSize.width * percent,
                       height: screenSize.width * percent,
                       alignment: .center)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        })
    }
    var bgColorThree: some View {
        Button(action: {bgColor = UIColor.cyan
            UserDefaults.standard.set(3, forKey: "bgColor")
        },
               label: {
            Color(UIColor.cyan)
                .frame(width: screenSize.width * percent,
                       height: screenSize.width * percent,
                       alignment: .center)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        })
    }
    var bgControl: some View {
            HStack {
                Spacer()
                bgColorOne.disabled(nightMode).accessibilityIdentifier("color1")
                Spacer()
                bgColorTwo.disabled(nightMode).accessibilityIdentifier("color2")
                Spacer()
                bgColorThree.disabled(nightMode).accessibilityIdentifier("color3")
                Spacer()
            }
    }
}

struct ReadingBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        ReadingBottomBar(nightMode: .constant(false),
                         bgColor: .constant(.darkText),
                         textColor: .constant(.darkText),
                         textFontSize: .constant(15.0),
                         loadState: .constant(.loadingContents))
    }
}
