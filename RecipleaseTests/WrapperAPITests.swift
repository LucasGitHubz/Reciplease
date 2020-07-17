//
//  WrapperAPITests.swift
//  RecipleaseTests
//
//  Created by kuroro on 05/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import XCTest
@testable import Reciplease

class WrapperAPITests: XCTestCase {
    var recipeService: RecipeService!
    
    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
    }
    
    func testPerformFunctionShouldFailedIfNilAppId() {
        let expectation = XCTestExpectation(description: "wait for queue change.")
        let urlDatas = URLData(appId: nil, appKey: Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String, from: 0, to: 50)
        
        ListService.ingredients.removeAll()
        
        let ingredient = "Lemon"
        ListService.ingredients.append(ingredient)
        let ingredients = ListService.ingredients.joined(separator: ",")
        
        recipeService.getRecipeData(url: URLSetter.getUrlString(userIngredients: ingredients, urlDatas)) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let completRecipe):
                XCTAssertNil(completRecipe)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testPerformFunctionShouldFailedIfAppIdValueNil() {
        let expectation = XCTestExpectation(description: "wait for queue change.")
        let urlDatas = URLData(appId: Bundle.main.object(forInfoDictionaryKey: "AppId") as? String, appKey: nil, from: 0, to: 50)
        
        ListService.ingredients.removeAll()
        
        let ingredient = "Lemon"
        ListService.ingredients.append(ingredient)
        let ingredients = ListService.ingredients.joined(separator: ",")
        
        recipeService.getRecipeData(url: URLSetter.getUrlString(userIngredients: ingredients, urlDatas)) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let completRecipe):
                XCTAssertNil(completRecipe)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
