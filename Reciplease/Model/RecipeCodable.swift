//
//  RecipeCodable.swift
//  Reciplease
//
//  Created by kuroro on 29/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import Foundation

struct FinalRecipe {
    var name: [String]
    var ingredient: [[String]]
    var time: [Double]
    var yield: [Double]
    var image: [String]
}

struct ResponseRecipe: Codable {
    let hits: [Hits]
}

struct Hits: Codable {
    let recipe: Recipe?

    enum CodingKeys: String, CodingKey {

        case recipe = "recipe"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try values.decodeIfPresent(Recipe.self, forKey: .recipe)
    }

}

struct Recipe: Codable {
    let label: String?
    let image: String?
    let yield: Double?
    let ingredients: [Ingredients]?
    let totalTime: Double?

    enum CodingKeys: String, CodingKey {
        case label = "label"
        case image = "image"
        case yield = "yield"
        case ingredients = "ingredients"
        case totalTime = "totalTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        yield = try values.decodeIfPresent(Double.self, forKey: .yield)
        ingredients = try values.decodeIfPresent([Ingredients].self, forKey: .ingredients)
        totalTime = try values.decodeIfPresent(Double.self, forKey: .totalTime)
    }
}

struct Ingredients: Codable {
    let text: String?
    let weight: Double?

    enum CodingKeys: String, CodingKey {

        case text = "text"
        case weight = "weight"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        weight = try values.decodeIfPresent(Double.self, forKey: .weight)
    }

}
