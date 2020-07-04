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
}
