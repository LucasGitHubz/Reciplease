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
    var datas = Datas()
    // MARK: Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecipListViewController {
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
extension RecipListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        datas.name = datas.nameTab[indexPath.row]
        datas.ingredients = datas.ingredientTab[indexPath.row]
        datas.time = String(datas.timeTab[indexPath.row])
        datas.yield = String(datas.yieldTab[indexPath.row])
        datas.image = datas.imageTab[indexPath.row]
        
        performSegue(withIdentifier: "segueToDetailVC", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.nameTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(cellType: CellView.self)
        let cell: CellView = tableView.dequeueReusableCell(for: indexPath)
        
        let name = datas.nameTab[indexPath.row]
        let ingredient = datas.ingredientTab[indexPath.row].joined(separator: ", ")
        let time = datas.timeTab[indexPath.row]
        let yield = datas.yieldTab[indexPath.row]
        let image = datas.imageTab[indexPath.row]
        
        cell.recipeName.text = name
        cell.recipeIngredient.text = ingredient
        cell.recipeTime.text = "\(time) min"
        cell.recipeYield.text = String(yield)
        cell.recipeImage.downloaded(from: image)
        
        return cell
    }
}
