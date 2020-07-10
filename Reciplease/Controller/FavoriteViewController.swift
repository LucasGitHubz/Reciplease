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

    // MARK: Properties
    private var datas = Datas()

    // MARK: Lyfecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfFavoriteSectionIsNull()
        tableView.reloadData()
    }

    // MARK: Methods
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
            successVC.datas.name = datas.name
            successVC.datas.ingredients = datas.ingredients
            successVC.datas.time = datas.time
            successVC.datas.yield = datas.yield
            successVC.datas.image = datas.image
        }
    }
}

// MARK: TableView gestion
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        datas.name = RecipeData.allRecipesData[indexPath.row].name ?? ""
        let ingredientsLine = RecipeData.allRecipesData[indexPath.row].ingredient ?? ""
        datas.ingredients = ingredientsLine.components(separatedBy: ",  ")
        datas.time = RecipeData.allRecipesData[indexPath.row].time ?? ""
        datas.yield = RecipeData.allRecipesData[indexPath.row].yield ?? ""
        datas.image = RecipeData.allRecipesData[indexPath.row].image ?? ""

        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(RecipeData.allRecipesData[indexPath.row])

            try? AppDelegate.viewContext.save()
            print("tab count \(RecipeData.allRecipesData.count)")
            tableView.deleteRows(at: [indexPath], with: .fade)
            checkIfFavoriteSectionIsNull()
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

        let view = CellView.loadFromNib()
        view.recipeName.text = name
        view.recipeIngredient.text = ingredient
        view.recipeTime.text = "\(time ?? "0") min"
        view.recipeYield.text = String(yield ?? "0")
        view.recipeImage.downloaded(from: image)

        cell.view.addSubview(view)

        return cell
    }
}
