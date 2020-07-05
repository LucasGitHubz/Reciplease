//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by kuroro on 05/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var recipeApiCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipeResponse", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let recipeApiIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://api.edamam.com/search?app_id=e420d102&app_key=4a114a87d4f0b31c76d41d19edd71b74&q=chocolate")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://api.edamam.com/search?app_id=e420d102&app_key=4a114a87d4f0b31c76d41d19edd71b74&q=chocolate")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error
    class RecipeApiError: Error {}
    static let error = RecipeApiError()
}
