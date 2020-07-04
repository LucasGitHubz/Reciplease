//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    private var name = String()
    private var ingredients = [String]()
    private var time = String()
    private var yield = String()
    private var image = String()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFavoriteSectionNull()
        tableView.reloadData()
    }

    private func checkFavoriteSectionNull() {
        guard RecipeData.allRecipesData.count > 0 else {
            tableView.isHidden = true
            return
        }
        tableView.isHidden = false
    }
}

extension FavoriteViewController {
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

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        name = RecipeData.allRecipesData[indexPath.row].name ?? ""
        let ingredientsLine = RecipeData.allRecipesData[indexPath.row].ingredient ?? ""
        ingredients = ingredientsLine.components(separatedBy: ", ")
        time = RecipeData.allRecipesData[indexPath.row].time ?? ""
        yield = RecipeData.allRecipesData[indexPath.row].yield ?? ""
        image = RecipeData.allRecipesData[indexPath.row].image ?? ""

        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(RecipeData.allRecipesData[indexPath.row])

            try? AppDelegate.viewContext.save()
            print("tab count \(RecipeData.allRecipesData.count)")
            tableView.deleteRows(at: [indexPath], with: .fade)
            checkFavoriteSectionNull()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeData.allRecipesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? RecipeListTableViewCell else {
            return UITableViewCell()
        }

        let name = RecipeData.allRecipesData[indexPath.row].name
        let ingredient = RecipeData.allRecipesData[indexPath.row].ingredient
        let time = RecipeData.allRecipesData[indexPath.row].time
        let yield = RecipeData.allRecipesData[indexPath.row].yield
        let image = RecipeData.allRecipesData[indexPath.row].image ?? "botCellShadow"

        cell.recipeTitleLabel.text = name
        cell.ingredientsLabel.text = ingredient
        cell.timeLabel.text = "\(time ?? "0") min"
        cell.yieldLabel.text = String(yield ?? "0")
        cell.recipeImageView.downloaded(from: image)

        return cell
    }
}
