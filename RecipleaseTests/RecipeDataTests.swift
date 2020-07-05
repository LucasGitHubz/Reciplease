//
//  RecipeDataTests.swift
//  RecipleaseTests
//
//  Created by kuroro on 05/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeDataTests: XCTestCase {
    var recipeService: RecipeService!

    override func setUp() {
        super.setUp()
        recipeService = RecipeService()
    }
}
