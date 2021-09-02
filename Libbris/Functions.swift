//
//  Functions.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-01.
//

import Foundation

func localizedString(text:String)->String{
let name = UserDefaults.standard.string(forKey: "language")
    //print(name ?? "nil")
    if(name == nil){
        let language = Bundle.main.preferredLocalizations.first
        let languageBundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
        let languageBundle = Bundle.init(path: languageBundlePath!)
        //print(NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: ""))
        return NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: "")
    }else{
        let languageBundlePath = Bundle.main.path(forResource: name, ofType: "lproj")
        let languageBundle = Bundle.init(path: languageBundlePath!)
        //print(NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: ""))
        return NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: "")
    }
}

func showLanguage()->Void{
    let name = UserDefaults.standard.string(forKey: "language")
    let language = Bundle.main.preferredLocalizations.first
    print(name ?? "nil")
    print(language ?? "nil")
}

func changeLanguage(language:String){
    UserDefaults.standard.set(language, forKey: "language")
}

func changeLanguage(languageCode:Int){
    switch(languageCode){
    case 0: changeLanguage(language:"en")
    case 1: changeLanguage(language:"zh-Hans")
    case 2: changeLanguage(language:"fr")
    default: print("will not reach")
    }
}

func getLanguageNumber()->Int{
    let name = UserDefaults.standard.string(forKey: "language")
    if(name == nil){
        let language = Bundle.main.preferredLocalizations.first
        switch language{
        case "en":return 0
        case "zh-Hans":return 1
        case "fr":return 2
        default: return 0
        }
    }else{
        switch name{
        case "en":return 0
        case "zh-Hans":return 1
        case "fr":return 2
        default: return 0
        }
    }
    
}
func getLanguageCode(language:String){}

extension  Notification.Name {
    static let switchLanguage = Notification.Name("switchLanguage")
}
