//
//  WrapperAPI.swift
//  Reciplease
//
//  Created by kuroro on 29/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

class WrapperAPI {
    static var shared = WrapperAPI()
    private init () {}

    var session = URLSession(configuration: .default)

    struct AlertError: Error {
        let error = "L'application n'a pas pu récupérer les données nécessaires. Vérifiez que vous êtes bien connecté à internet"
    }

    func perform<T: Decodable>(_ request: URLRequest, decode decodable: T.Type, result: @escaping (Result<T, AlertError>) -> Void) {

        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return result(.failure(AlertError.init()))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return result(.failure(AlertError.init()))
                }
                do {
                    let object = try JSONDecoder().decode(decodable, from: data)
                    result(.success(object))
                } catch {
                    result(.failure(AlertError.init()))
                }
            }
        }
        task.resume()
    }
    
}
