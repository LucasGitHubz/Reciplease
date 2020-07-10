//
//  CellView.swift
//  Reciplease
//
//  Created by kuroro on 10/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class CellView: UIView, NibLoadable {
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredient: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
}
