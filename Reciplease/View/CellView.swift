//
//  RecipeListTableViewCell.swift
//  Reciplease
//
//  Created by kuroro on 01/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit
import Reusable

class CellView: UITableViewCell, NibReusable {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeIngredient: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeName.text = ""
        recipeIngredient.text = ""
        recipeTime.text = ""
        recipeYield.text = ""
    }
}
