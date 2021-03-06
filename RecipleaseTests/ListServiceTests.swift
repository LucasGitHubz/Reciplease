//
//  ListServiceTests.swift
//  RecipleaseTests
//
//  Created by kuroro on 05/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import XCTest
@testable import Reciplease

class ListServiceTests: XCTestCase {
    func testWhenAddingNewValueToIngredientsByUserDefaultUtilisationThenIngredientsCountUp() {
        let ingredient = "Lemon"
        let ingredientsCount = ListService.ingredients.count
        ListService.userDefaultKey = "ingredient"

        ListService.ingredients.append(ingredient)

        XCTAssertTrue(ListService.ingredients.count > ingredientsCount)
    }

    func testWhenAddingNewValueButTheUserDefaultKeyIsWrongThenAddingAnEmptyArray() {
        let ingredient = "Lemon"
        ListService.userDefaultKey = ""

        ListService.ingredients.append(ingredient)

        XCTAssertTrue(ListService.ingredients == [])
    }
}
