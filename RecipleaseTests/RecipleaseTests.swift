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
        recipeService.getRecipeData(userIngredients: "", callBack: { (success, completRecipe) in
            XCTAssertFalse(success)
            XCTAssertNil(completRecipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }

    func testGetRecipeDataShouldSuccessCallbackIfAllIsRight() {
        let expectation = XCTestExpectation(description: "wait for queue change.")
        recipeService.getRecipeData(userIngredients: "chocolate", callBack: { (success, completRecipe) in
            XCTAssertTrue(success)
            XCTAssertNotNil(completRecipe)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }
}
