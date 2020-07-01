//
//  SearchViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    private var nameTab = [String?]()
    private var ingredientTab = [[String]]()
    private var yieldTab = [Double?]()
    private var timeTab = [Double?]()
    var imageTab = [String]()

    private func addIngredientToList() {
        guard let ingredient = textField.text, textField.text != "" else {
            presentAlert(message: AlertMessage.init().emptyTextFieldError)
            return
        }
        ListService.ingredients.append(ingredient)
        tableView.reloadData()
    }

    private func getRecipe() {
        guard ListService.ingredients != [] else {
            return presentAlert(message: AlertMessage.init().emptyListError)
        }
        let ingredients = ListService.ingredients.joined(separator: ",")
        RecipeService.shared.getTranslation(userIngredients: ingredients) { (success, completRecipe) in
            DispatchQueue.main.async {
                if success {
                    self.update(with: completRecipe, completionHandler: { (success) in
                        if success {
                            self.performSegue(withIdentifier: "segueToListVC", sender: self)
                        } else {
                            return
                        }
                    })
                } else {
                    self.presentAlert(message: AlertMessage.init().programError)
                }
            }
        }
    }

    private func update(with: FinalRecipe?, completionHandler: (Bool) -> Void) {
        guard let recipesData = with else {
            presentAlert(message: AlertMessage.init().programError)
            return
        }

        nameTab = recipesData.name
        ingredientTab = recipesData.ingredient
        yieldTab = recipesData.yield
        timeTab = recipesData.time
        imageTab = recipesData.image
        completionHandler(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToListVC" {
            guard let successVC = segue.destination as? RecipListViewController else {
                return presentAlert(message: AlertMessage.init().programError)
            }
            successVC.nameTab = nameTab
            successVC.ingredientTab = ingredientTab
            successVC.yieldTab = yieldTab
            successVC.timeTab = timeTab
            successVC.imageTab = imageTab
        }
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        addIngredientToList()
        textField.resignFirstResponder()
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        ListService.ingredients.removeAll()
        tableView.reloadData()
        textField.resignFirstResponder()
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        getRecipe()
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListService.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = ListService.ingredients[indexPath.row]
        cell.ingredientLabel.text = ingredient
        
        return cell
    }
}

extension SearchViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
