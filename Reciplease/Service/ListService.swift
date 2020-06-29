//
//  ListService.swift
//  Reciplease
//
//  Created by kuroro on 23/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

class ListService {
    static var shared = ListService()
    private init() {}

    static var ingredients: [String] {
        get {
            return UserDefaults.standard.object(forKey: "ingredient") as? [String] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ingredient")
            print("ingredientTab \(ingredients)")
        }
    }
}
