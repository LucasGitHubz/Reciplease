//
//  SearchViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var addButton: CustomButton!
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var midActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var botActivityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    private var nameTab = [String]()
    private var ingredientTab = [[String]]()
    private var timeTab = [Double]()
    private var yieldTab = [Double]()
    private var imageTab = [String]()

    private func toogleActivityIndicator(idIndicator: Int, shown: Bool) {
        if idIndicator == 1 {
            addButton.isHidden = !shown
            midActivityIndicator.isHidden = shown
        } else {
            searchButton.isHidden = !shown
            botActivityIndicator.isHidden = shown
        }
    }

    private func addIngredientToList() {
        guard let ingredient = textField.text, textField.text != "" else {
            presentAlert(message: AlertMessage.init().emptyTextFieldError)
            return
        }
        ListService.ingredients.append(ingredient)
        tableView.reloadData()
        textField.text = ""
    }

    private func getRecipe(idIndicator: Int) {
        toogleActivityIndicator(idIndicator: idIndicator, shown: false)
        guard ListService.ingredients != [] else {
            return presentAlert(message: AlertMessage.init().emptyListError)
        }
        let ingredients = ListService.ingredients.joined(separator: ",")
        RecipeService.shared.getTranslation(userIngredients: ingredients) { (success, completRecipe) in
            DispatchQueue.main.async {
                self.toogleActivityIndicator(idIndicator: idIndicator, shown: true)
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
        timeTab = recipesData.time
        yieldTab = recipesData.yield
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
            successVC.timeTab = timeTab
            successVC.yieldTab = yieldTab
            successVC.imageTab = imageTab
        }
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        toogleActivityIndicator(idIndicator: 1, shown: false)
        addIngredientToList()
        toogleActivityIndicator(idIndicator: 1, shown: true)
        textField.resignFirstResponder()
    }
    
    @IBAction func didTapClearButton(_ sender: Any) {
        ListService.ingredients.removeAll()
        tableView.reloadData()
        textField.resignFirstResponder()
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        getRecipe(idIndicator: 2)
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
        cell.ingredientLabel.text = "- \(ingredient)"
        
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
