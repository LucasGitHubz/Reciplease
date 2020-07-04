//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var getDirectionButton: CustomButton!
    @IBOutlet weak var starImage: UIImageView!
    
    var name = String()
    var ingredients = [String]()
    var time = String()
    var yield = String()
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRecipeAlreadyAddedToFavorite(name)
        recipeTitleLabel.text = name
        timeLabel.text = "\(time) min"
        yieldLabel.text = yield
        recipeImageView.downloaded(from: image)

        navigationController?.navigationBar.setBackButtonTitle()
    }

    private func checkRecipeAlreadyAddedToFavorite(_ name: String) {
        guard RecipeData.allRecipesData.count > 0 else {
            return
        }

        for index in 0...RecipeData.allRecipesData.count - 1 where RecipeData.allRecipesData[index].name == name {
                starImage.tintColor = #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1)
            }
    }

    private func addRecipeToFavoriteOrDelete() {
        if starImage.tintColor == #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1) {
            RecipeData.deleteRecipeData(name)
            starImage.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            RecipeData.saveRecipeData(name, ingredients, time, yield, image)
            starImage.tintColor = #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1)
        }
    }

    @IBAction func didTapOnStarButton(_ sender: Any) {
        addRecipeToFavoriteOrDelete()
        print("tab count\(RecipeData.allRecipesData.count)")
    }
    
    @IBAction func didTapGetDirectionButton(_ sender: Any) {
    }
}

extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientListCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        
        cell.ingredientLabel.text = "- \(ingredient)"
        
        return cell
    }
}
