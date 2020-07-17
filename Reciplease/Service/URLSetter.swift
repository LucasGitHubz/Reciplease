//
//  URLSetter.swift
//  Reciplease
//
//  Created by kuroro on 16/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

struct URLData {
    var appId: String?
    var appKey: String?
    var from: Int
    var to: Int
}

class URLSetter {
    // MARK: Methods
    static func getUrlString(userIngredients: String, _ datas: URLData) -> String {
        guard let appId = datas.appId else {
            return ""
        }

        guard let appKey = datas.appKey else {
            return ""
        }

        let recipeUrl = "https://api.edamam.com/search?app_id=\(appId)&app_key=\(appKey)&q=\(userIngredients)&from=\(datas.from)&to=\(datas.to)"
        
        return recipeUrl
    }
}
