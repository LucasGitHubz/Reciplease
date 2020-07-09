//
//  RecipeService.swift
//  Reciplease
//
//  Created by kuroro on 29/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

class RecipeService {
    // MARK: Properties
    var appId = Bundle.main.object(forInfoDictionaryKey: "AppId") as? String
    var appKey = Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String

    // MARK: Methods
    func getUrlString(_ userIngredients: String, appId: String?, appKey: String?) -> String {
        guard let appId = appId else {
            return ""
        }

        guard let appKey = appKey else {
            return ""
        }

        let recipeUrl = "https://api.edamam.com/search?app_id=\(appId)&app_key=\(appKey)&q=\(userIngredients)"
        
        return recipeUrl
    }
    // This method returns, if successful, the recipesData to be used in RecipListVC. Else, displays the corresponding error
    func getRecipeData(userIngredients: String, finalResult: @escaping (Result<FinalRecipe, WrapperAPI.AlertError>) -> Void) {
        WrapperAPI.shared.perform(url: getUrlString(userIngredients, appId: appId, appKey: appKey), decode: ResponseRecipe.self) { (result) in
            switch result {
            case .failure(let error):
            finalResult(.failure(error))
            case .success(let recipesData):
                guard recipesData.hits.count > 0 else {
                    return finalResult(.failure(WrapperAPI.AlertError.init()))
                }
                
                let names = recipesData.hits.compactMap { $0.recipe?.label }
                let ingredients = self.makeIngredientTab(with: recipesData)
                let yield = recipesData.hits.compactMap { $0.recipe?.yield }
                let time = recipesData.hits.compactMap { $0.recipe?.totalTime }
                let image = recipesData.hits.compactMap { $0.recipe?.image }
                
                let completRecipe = FinalRecipe(name: names, ingredient: ingredients, time: time, yield: yield, image: image)
                
                finalResult(.success(completRecipe))
            }
        }
    }
    
    // This method transform an array [[Ingredients]?] to an array [[String]], it takes juste the name of each ingredients and creates array with it.
    private func makeIngredientTab(with: ResponseRecipe) -> [[String]] {
        var ingredients = [[Ingredients]?]()
        var finalIngredientTab = [[String]]()
        
        // Creating an array of [Ingredient arrays]
        ingredients = with.hits.compactMap { $0.recipe?.ingredients }
        
        // Creating a String array of each [Ingredients array] contained in ingredients (of type: [[Ingredients]])
        // Then adding this String array to an array of String array
        for ingredientTab in ingredients {
            finalIngredientTab.append(ingredientTab?.compactMap { $0.text } ?? [])
        }
        return finalIngredientTab
    }
}
