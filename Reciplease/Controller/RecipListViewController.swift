//
//  RecipListViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class RecipListViewController: UIViewController {
    // MARK: Properties
    var nameTab = [String?]()
    var ingredientTab = [[String]]()
    var timeTab = [Double]()
    var yieldTab = [Double]()
    var imageTab = [String]()
}

extension RecipListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC" {
            guard let successVC = segue.destination as? RecipListViewController else {
                return presentAlert(message: AlertMessage.init().programError)
            }
            successVC.nameTab = nameTab
            successVC.ingredientTab = ingredientTab
            successVC.timeTab = timeTab
            successVC.yieldTab = yieldTab
            successVC.imageTab = imageTab
        }
    }
}

extension RecipListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameTab.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeListTableViewCell else {
            return UITableViewCell()
        }
        
        let name = nameTab[indexPath.row]
        let ingredient = ingredientTab[indexPath.row].joined(separator: ", ")
        let time = timeTab[indexPath.row]
        let yield = yieldTab[indexPath.row]
        let image = imageTab[indexPath.row]

        cell.recipeImageView.downloaded(from: image)
        cell.recipeTitleLabel.text = name
        cell.ingredientsLabel.text = ingredient
        cell.timeLabel.text = "\(time) min"
        cell.yieldLabel.text = String(yield)

        return cell
    }
}
