//
//  RecipListViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class RecipListViewController: CustomViewController {
    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties
    var recipe = Datas()
    private var from = 50
    private var to = 100
    
    // MARK: Methods
    func loadNextBach() {
        let urlDatas = URLData(appId: Bundle.main.object(forInfoDictionaryKey: "AppId") as? String, appKey: Bundle.main.object(forInfoDictionaryKey: "AppKey") as? String, from: from, to: to)
        
        guard ListService.ingredients != [] else {
            return presentAlert(message: AlertMessage.init().emptyListError)
        }
        
        let ingredients = ListService.ingredients.joined(separator: ",")
        RecipeService.init().getRecipeData(url: URLSetter.getUrlString(userIngredients: ingredients, urlDatas)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.presentAlert(message: error.error)
                case .success(let completRecipe):
                    self.update(userIngredients: ingredients, data: completRecipe, completionHandler: { (success) in
                        if success {
                            self.tableView.reloadData()
                        } else {
                            self.presentAlert(message: AlertMessage.init().programError)
                        }
                    })
                }
            }
        }
    }
    
    private func update(userIngredients: String, data: FinalRecipe?, completionHandler: (Bool) -> Void) {
        guard let recipesData = data else {
            presentAlert(message: AlertMessage.init().programError)
            return
        }
        
        recipe.nameTab.append(contentsOf: recipesData.name.compactMap { $0 })
        recipe.ingredientTab.append(contentsOf: recipesData.ingredient.compactMap { $0 })
        recipe.timeTab.append(contentsOf: recipesData.time.compactMap { $0 })
        recipe.yieldTab.append(contentsOf: recipesData.yield.compactMap { $0 })
        recipe.imageTab.append(contentsOf: recipesData.image.compactMap { $0 })
        
        completionHandler(true)
    }
}

extension RecipListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC" {
            guard let successVC = segue.destination as? DetailsViewController else {
                return presentAlert(message: AlertMessage.init().programError)
            }
            
            successVC.recipe = recipe
        }
    }
}

// MARK: TableView gestion
extension RecipListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipe.name = recipe.nameTab[indexPath.row]
        recipe.ingredients = recipe.ingredientTab[indexPath.row]
        recipe.time = String(recipe.timeTab[indexPath.row])
        recipe.yield = String(recipe.yieldTab[indexPath.row])
        recipe.image = recipe.imageTab[indexPath.row]
        
        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.nameTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: CellView.self)
        let cell: CellView = tableView.dequeueReusableCell(for: indexPath)
        
        if (indexPath.row + 30) == recipe.nameTab.count && recipe.nameTab.count < 100 {
            loadNextBach()
            return cell
        }
        
        let name = recipe.nameTab[indexPath.row]
        let ingredient = recipe.ingredientTab[indexPath.row].joined(separator: ", ")
        let time = recipe.timeTab[indexPath.row]
        let yield = recipe.yieldTab[indexPath.row]
        let image = recipe.imageTab[indexPath.row]
        
        cell.recipeName.text = name
        cell.recipeIngredient.text = ingredient
        cell.recipeTime.text = "\(time) min"
        cell.recipeYield.text = String(yield)
        cell.recipeImage.downloaded(from: image)
        
        return cell
    }
}
