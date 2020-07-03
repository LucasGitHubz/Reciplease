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
    var nameTab = [String]()
    var ingredientTab = [[String]]()
    var timeTab = [Double]()
    var yieldTab = [Double]()
    var imageTab = [String]()

    private var name = String()
    private var ingredients = [String]()
    private var time = String()
    private var yield = String()
    private var image = String()

    override func viewDidLoad() {
        navigationController?.navigationBar.setBackButtonTitle()
    }
}

extension RecipListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC" {
            guard let successVC = segue.destination as? DetailsViewController else {
                return presentAlert(message: AlertMessage.init().programError)
            }
            successVC.name = name
            successVC.ingredients = ingredients
            successVC.time = time
            successVC.yield = yield
            successVC.image = image
        }
    }
}

extension RecipListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = nameTab[indexPath.row]
        ingredients = ingredientTab[indexPath.row]
        time = String(timeTab[indexPath.row])
        yield = String(yieldTab[indexPath.row])
        image = imageTab[indexPath.row]

        performSegue(withIdentifier: "segueToDetailVC", sender: self)
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
