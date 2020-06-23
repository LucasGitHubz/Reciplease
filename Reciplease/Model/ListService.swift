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
    
    private(set) var ingredients = [Ingredients]()
    
    func add(ingredient: Ingredients) {
        ingredients.append(ingredient)
    }
}
