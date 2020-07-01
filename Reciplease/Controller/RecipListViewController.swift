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
    var yieldTab = [Double?]()
    var timeTab = [Double?]()
    var imageTab = [String]()

    override func viewDidLoad() {
    }
}

extension RecipListViewController: UITableViewDataSource {
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
        let image = imageTab[indexPath.row]

        cell.recipeImageView.downloaded(from: image)
        cell.recipeTitleLabel.text = name
        cell.ingredientsLabel.text = ingredient

        return cell
    }
}
