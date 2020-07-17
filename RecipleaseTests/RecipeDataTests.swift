//
//  RecipeDataTests.swift
//  RecipleaseTests
//
//  Created by kuroro on 05/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import XCTest
@testable import Reciplease
import CoreData

class RecipeDataTests: XCTestCase {
    var recipe = Datas()
    
    let recipeName = "Brioche"
    let ingredient = ["farine", "oeufs", "sucre"]
    let time = "10"
    let yield = "4"
    let image = "https://www.edamam.com/web-img/a10/a10c3d635c6b045750217609a28a474a.jpg"
    
    override func setUp() {
        super.setUp()
        recipe.name = recipeName
        recipe.ingredients = ingredient
        recipe.time = time
        recipe.yield = yield
        recipe.image = image
    }
    
    func testWhenAddingNewValueToRecipeDataEntityThenRecipeDataCountUp() {
        
        let testRecipeDataCount = RecipeData.allRecipesData.count
        
        RecipeData.saveRecipeData(datas: recipe)
        print("recipedata count : \(RecipeData.allRecipesData.count)")
        
        XCTAssertTrue(RecipeData.allRecipesData.count > testRecipeDataCount)
    }
    
    func deleteAllDataFromRecipeDataEntity() {
        RecipeData.allRecipesData.forEach { AppDelegate.viewContext.delete($0) }
        
    }
    
    func testWhenDeletingValueFromRecipeDataEntityThenThisValueWas() {
        deleteAllDataFromRecipeDataEntity()
        print("recipedata count : \(RecipeData.allRecipesData.count)")
        
        RecipeData.saveRecipeData(datas: recipe)
        
        RecipeData.deleteRecipeData("Brioche")
        
        XCTAssertTrue(RecipeData.allRecipesData.count == 0)
    }
}
