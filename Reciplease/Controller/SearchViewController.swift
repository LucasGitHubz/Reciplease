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

    @IBAction func didTapAddButton(_ sender: Any) {
        guard let ingredient = textField.text else {
                return
        }
        ListService.ingredients.append(ingredient)
        tableView.reloadData()
    }

    @IBAction func didTapClearButton(_ sender: Any) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)

        let ingredient = ListService.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient

        return cell
    }
}