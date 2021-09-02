//
//  strings.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-01.
//

import Foundation
let strLanguageSetting = "Language Setting"
let strInfos = "Information"
let strConfig = "Configuration"
let strSkip = "Skip"
let strTeam = "Team"
let strMail = "mail"
let strVersion = "Version"
let strOnReading = "ON READING"
let strToRead = "TO READ"
let strEnglish = "English"
let strChinese = "Chinese(Simplified)"
let strFrench = "French"
let strBack = "<Back"
let apiGetBookByCategory = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/category/\(1)?start=\(1)&size=\(1)"
let apiSearch = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/searchByName?name=\(1)"
let apiGetbook = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/\(1)"
let apiGetChapterContent = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/\(1)/chapter/\(1)"
let apiGetAllChapters = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/book/\(1)/chapters"
let apiFindCategoriesByLanguage = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/category/findByLanguage?lang=\("en")"
let apiAllGetFeaturedBookList = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/featured/all/\("long")"
let apiGetFeaturedBookList = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/featured/\("long")/\("long")"
let apiListAllLanguages = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/language/list"
let apiRankControllerSearch = "http://libbris2021.us-west-2.elasticbeanstalk.com/ws/rank/\("rankTypeName")/\("categoryId")/\("cycle")/\("size")"




