//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: CustomViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private var recipe = Datas()

    // MARK: Lyfecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toogleActivityIndicator(shown: false)
        checkIfFavoriteSectionIsNull()
        tableView.reloadData()
        toogleActivityIndicator(shown: true)
    }

    // MARK: Methods
    private func toogleActivityIndicator(shown: Bool) {
            activityIndicator.isHidden = shown
    }

    private func checkIfFavoriteSectionIsNull() {
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
            successVC.recipe.name = recipe.name
            successVC.recipe.ingredients = recipe.ingredients
            successVC.recipe.time = recipe.time
            successVC.recipe.yield = recipe.yield
            successVC.recipe.image = recipe.image
        }
    }
}

// MARK: TableView gestion
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe.name = RecipeData.allRecipesData[indexPath.row].name ?? ""
        let ingredientsLine = RecipeData.allRecipesData[indexPath.row].ingredient ?? ""
        recipe.ingredients = ingredientsLine.components(separatedBy: ",  ")
        recipe.time = RecipeData.allRecipesData[indexPath.row].time ?? ""
        recipe.yield = RecipeData.allRecipesData[indexPath.row].yield ?? ""
        recipe.image = RecipeData.allRecipesData[indexPath.row].image ?? ""

        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toogleActivityIndicator(shown: false)
            AppDelegate.viewContext.delete(RecipeData.allRecipesData[indexPath.row])

            try? AppDelegate.viewContext.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
            checkIfFavoriteSectionIsNull()
            toogleActivityIndicator(shown: true)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeData.allRecipesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: CellView.self)
        let cell: CellView = tableView.dequeueReusableCell(for: indexPath)

        let name = RecipeData.allRecipesData[indexPath.row].name
        let ingredient = RecipeData.allRecipesData[indexPath.row].ingredient
        let time = RecipeData.allRecipesData[indexPath.row].time
        let yield = RecipeData.allRecipesData[indexPath.row].yield
        let image = RecipeData.allRecipesData[indexPath.row].image ?? "botCellShadow"

        cell.recipeName.text = name
        cell.recipeIngredient.text = ingredient
        cell.recipeTime.text = "\(time ?? "0") min"
        cell.recipeYield.text = String(yield ?? "0")
        cell.recipeImage.downloaded(from: image)

        return cell
    }
}
