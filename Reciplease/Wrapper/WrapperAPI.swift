//
//  WrapperAPI.swift
//  Reciplease
//
//  Created by kuroro on 29/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation
import Alamofire

class WrapperAPI {
    // MARK: Singleton pattern
    static var shared = WrapperAPI()
    private init () {}

    // MARK: Properties
    var appId = Bundle.main.object(forInfoDictionaryKey: "AppId") as? String
    var appKey = Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String

    struct AlertError: Error {
        let error = "L'application n'a pas pu récupérer les données nécessaires. Vérifiez que vous êtes bien connecté à internet"
    }

    // MARK: Methods
    func getUrlString(_ userIngredients: String, appId: String?, appKey: String?) -> String {
        guard let appId = appId else {
            return AlertError.init().error
        }

        guard let appKey = appKey else {
            return AlertError.init().error
        }

        let recipeUrl = "https://api.edamam.com/search?app_id=\(appId)&app_key=\(appKey)&q=\(userIngredients)"
        
        return recipeUrl
    }
    
    func perform<T: Decodable>(userIngredient: String, decode decodable: T.Type, result: @escaping (Result<T, AlertError>) -> Void) {
        AF.request(getUrlString(userIngredient, appId: appId, appKey: appKey))
        .validate()
        .responseDecodable(of: decodable.self) { (response) in
                guard let object = response.value else {
                    return result(.failure(AlertError.init()))
                }
                result(.success(object))
        }
    }
}
