//
//  Functions.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-01.
//

import Foundation

func localizedString(text:String)->String{
let name = UserDefaults.standard.string(forKey: "language")
    print(name ?? "nil")
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

extension  Notification.Name {
    static let switchLanguage = Notification.Name("switchLanguage")
}
