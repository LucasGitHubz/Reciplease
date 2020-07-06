//
//  RecipeData.swift
//  Reciplease
//
//  Created by kuroro on 03/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation
import CoreData

class RecipeData: NSManagedObject {
    static var allRecipesData: [RecipeData] {
        let request: NSFetchRequest<RecipeData> = RecipeData.fetchRequest()
        guard let data = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return data
    }
    
    static func saveRecipeData(_ name: String, _ ingredients: [String], _ time: String, _ yield: String, _ image: String) {
        let recipeData = RecipeData(context: AppDelegate.viewContext)
        recipeData.name = name
        recipeData.ingredient = ingredients.joined(separator: ", ")
        recipeData.time = time
        recipeData.yield = yield
        recipeData.image = image
        
        try? AppDelegate.viewContext.save()
    }

    // Delete the recipe datas corresponding to the recipe's name given as parameter
    static func deleteRecipeData(_ name: String) {
        for index in 0...RecipeData.allRecipesData.count - 1 where RecipeData.allRecipesData[index].name == name {
            AppDelegate.viewContext.delete(RecipeData.allRecipesData[index])
            try? AppDelegate.viewContext.save()
            break
        }
    }
}
