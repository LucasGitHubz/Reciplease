//
//  RecipeService.swift
//  Reciplease
//
//  Created by kuroro on 29/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

class RecipeService {
    static var shared = RecipeService()
    private init() {}

    // MARK: Properties

    // MARK: Methods

    private func getUrl(_ userIngredients: String) -> String {
        guard let appId = Bundle.main.object(forInfoDictionaryKey: "AppId") as? String else {
            fatalError()
        }

        guard let appKey = Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String else {
            fatalError()
        }

        let recipeUrl = "https://api.edamam.com/search?app_id=\(appId)&app_key=\(appKey)&q=\(userIngredients)"
        
        return recipeUrl
    }
    // This method returns, if successful, the recipesData to be used in RecipListVC. Else, displays the corresponding error
    func getRecipeData(userIngredients: String, callBack: @escaping (Bool, FinalRecipe?) -> Void) {
        WrapperAPI.shared.perform(url: getUrl(userIngredients), decode: ResponseRecipe.self) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                callBack(false, nil)
            case .success(let recipesData):
                guard recipesData.hits.count > 0 else {
                    callBack(false, nil)
                    return
                }

                let names = recipesData.hits.compactMap { $0.recipe?.label }
                let ingredients = self.makeIngredientTab(with: recipesData)
                let yield = recipesData.hits.compactMap { $0.recipe?.yield }
                let time = recipesData.hits.compactMap { $0.recipe?.totalTime }
                let image = recipesData.hits.compactMap { $0.recipe?.image }

                let completRecipe = FinalRecipe(name: names, ingredient: ingredients, time: time, yield: yield, image: image)
                callBack(true, completRecipe)
            }
        }
    }

    // This method transform an array [[Ingredients]?] to an array [[String]], its takes juste the name of each ingredients and creates array with it.
    private func makeIngredientTab(with: ResponseRecipe) -> [[String]] {
        var ingredients = [[Ingredients]?]()
        var ingredientTab = [String]()
        var finalIngredientTab = [[String]]()
        
        // Creating an array of Ingredient arrays
        ingredients = with.hits.compactMap { $0.recipe?.ingredients }

        // Creating a String array of each Ingredients array contained in the array of Ingredients array (ingredients)
        // Then adding this String array to an array of String array
        for index in ingredients {
            ingredientTab.removeAll()
            for i in 0...(index?.count ?? 0) - 1 {
                ingredientTab.append(index?[i].text ?? "")
            }
            finalIngredientTab.append(ingredientTab)
        }
        return finalIngredientTab
    }
}
