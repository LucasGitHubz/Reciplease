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
    static var shared = WrapperAPI()
    private init () {}

    struct AlertError: Error {
        let error = "L'application n'a pas pu récupérer les données nécessaires. Vérifiez que vous êtes bien connecté à internet"
    }
    
    func perform<T: Decodable>(url: String, decode decodable: T.Type, result: @escaping (Result<T, AlertError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: decodable.self) { (response) in
                guard let object = response.value else {
                    return result(.failure(AlertError.init()))
                }
                result(.success(object))
        }
    }
}
