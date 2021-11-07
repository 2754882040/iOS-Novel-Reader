//
//  Functions.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-01.
//

import Foundation

enum LoadState {
case loading, success, failure
}

func localizedString(text: String) -> String {
let name = UserDefaults.standard.string(forKey: "language")
    if name == nil {
        let language = Bundle.main.preferredLocalizations.first
        let languageBundlePath = Bundle.main.path(forResource: language, ofType: "lproj")
        let languageBundle = Bundle.init(path: languageBundlePath!)
        return NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: "")
    } else {
        let languageBundlePath = Bundle.main.path(forResource: name, ofType: "lproj")
        let languageBundle = Bundle.init(path: languageBundlePath!)
        return NSLocalizedString(text, tableName: "Localizable", bundle: languageBundle!, value: "?", comment: "")
    }
}

func showLanguage() {
    let name = UserDefaults.standard.string(forKey: "language")
    let language = Bundle.main.preferredLocalizations.first
    print(name ?? "nil")
    print(language ?? "nil")
}

func changeLanguage(language: String) {
    UserDefaults.standard.set(language, forKey: "language")
}

func changeLanguage(languageCode: Int) {
    switch languageCode {
    case 0: changeLanguage(language: "en")
    case 1: changeLanguage(language: "zh-Hans")
    case 2: changeLanguage(language: "fr")
    default: print("will not reach")
    }
}

func getLanguageNumber() -> Int {
    let name = UserDefaults.standard.string(forKey: "language")
    if name == nil {
        let language = Bundle.main.preferredLocalizations.first
        switch language {
        case "en":return 0
        case "zh-Hans":return 1
        case "fr":return 2
        default: return 0
        }
    } else {
        switch name {
        case "en": return 0
        case "zh-Hans": return 1
        case "fr": return 2
        default: return 0
        }
    }
}
func getLanguageCode(language: String) {}

extension  Notification.Name {
    static let switchLanguage = Notification.Name("switchLanguage")
    static let refreshBook = Notification.Name("refreshBook")
}

func decodeData<T: Codable>(data: Data) throws -> T {
    let jsonDecoder = JSONDecoder()
    do {
        let parsedJSON = try jsonDecoder.decode(T.self, from: data)
        print(parsedJSON)
        return parsedJSON
    } catch {
        print(error)
        fatalError("\(error)")
    }
}
let fullPath = NSHomeDirectory().appending("/Documents/").appending("bookShelf")

func getBookByCategoryAPI(categoryId: Int, start: Int, size: Int) -> String {
    return "\(apiWebsite)book/category/\(categoryId)?start=\(start)&size=\(size)"
}

func searchAPI(name: String) -> String {
    return "\(apiWebsite)book/searchByName?name=\(name)"
}

func getBookAPI(bookId: Int) -> String {
    return "\(apiWebsite)book/\(bookId)"
}
func getChapterContentAPI(bookId: Int, chapterId: Int) -> String {
    return "\(apiWebsite)book/\(bookId)/chapter/\(chapterId)"
}

func getAllChaptersAPI(bookId: Int) -> String {
    return "\(apiWebsite)book/\(bookId)/chapters"
}

func findCategoriesByLanguageAPI(language: String) -> String {
    return "\(apiWebsite)category/findByLanguage?lang=\(language)"
}

func getFeaturedBookListAPI(bookCategoryId: Int) -> String {
    return "\(apiWebsite)featured/all/\(bookCategoryId)"
}

func getFeaturedBookListAPI(featureBookId: Int, bookCategoryId: Int) -> String {
    return "\(apiWebsite)featured/\(featureBookId)/\(bookCategoryId)"
}

func listAllLanguagesAPI() -> String {
    return "\(apiWebsite)language/list"
}

func rankControllerSearch(rankTypeName: String, categoryId: Int, cycle: String, size: Int) -> String {
    return "\(apiWebsite)rank/\(rankTypeName)/\(categoryId)/\(cycle)/\(size)"
}
