//
//  Favorites.swift
//  Reciplease
//
//  Created by kuroro on 03/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation
import CoreData

class Favorite: NSManagedObject {
    static var allFavoritesData: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        guard let data = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return data
    }
}
