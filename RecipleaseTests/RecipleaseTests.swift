//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeServiceTests: XCTestCase {
    var recipeService: RecipeService!
    
    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
    }

    func testGetRecipeDataShouldPostFailedCallbackIfNoIngredients() {
        let expectation = XCTestExpectation(description: "wait for queue change.")
        let urlDatas = URLData(appId: Bundle.main.object(forInfoDictionaryKey: "AppId") as? String, appKey: Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String, from: 0, to: 50)

        recipeService.getRecipeData(url: URLSetter.getUrlString(userIngredients: "", urlDatas)) { (result) in
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

    func testGetRecipeDataShouldSuccessCallbackIfAllDatasAreGood() {
        let expectation = XCTestExpectation(description: "wait for queue change.")
        let urlDatas = URLData(appId: Bundle.main.object(forInfoDictionaryKey: "AppId") as? String, appKey: Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String, from: 0, to: 50)
        
        ListService.ingredients.removeAll()
        
        let ingredient = "Lemon"
        ListService.ingredients.append(ingredient)
        let ingredients = ListService.ingredients.joined(separator: ",")

        recipeService.getRecipeData(url: URLSetter.getUrlString(userIngredients: ingredients, urlDatas)) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let completRecipe):
                XCTAssertNotNil(completRecipe)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
