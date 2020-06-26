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

    private func addIngredientToList() {
        guard let ingredient = textField.text, textField.text != "" else {
            presentAlert(message: AlertMessage.init().emptyTextFieldError)
            return
        }
        ListService.ingredients.append(ingredient)
        tableView.reloadData()
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
