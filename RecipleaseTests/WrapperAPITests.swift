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

    func testPerformFunctionShouldFailedIfWrongIdAndKey() {
        WrapperAPI.shared.appId = ""
        WrapperAPI.shared.appKey = ""
        let expectation = XCTestExpectation(description: "wait for queue change.")
        recipeService.getRecipeData(userIngredients: "chocolate", callBack: { (success, completRecipe)
            in
            XCTAssertFalse(success)
            XCTAssertNil(completRecipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }

    func testPerformFunctionShouldFailedIfAppIdValueNil() {
        WrapperAPI.shared.appId = nil
        WrapperAPI.shared.appKey = ""
        let expectation = XCTestExpectation(description: "wait for queue change.")
        recipeService.getRecipeData(userIngredients: "chocolate", callBack: { (success, completRecipe)
            in
            XCTAssertFalse(success)
            XCTAssertNil(completRecipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }

    func testPerformFunctionShouldFailedIfAppKeyValueNil() {
        WrapperAPI.shared.appId = ""
        WrapperAPI.shared.appKey = nil
        let expectation = XCTestExpectation(description: "wait for queue change.")
        recipeService.getRecipeData(userIngredients: "chocolate", callBack: { (success, completRecipe)
            in
            XCTAssertFalse(success)
            XCTAssertNil(completRecipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
}
