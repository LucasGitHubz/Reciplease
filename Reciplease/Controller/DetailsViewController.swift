//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var getDirectionButton: CustomButton!
    
    var name = String()
    var ingredients = [String]()
    var time = String()
    var yield = String()
    var image = String()
    
    override func viewDidLoad() {
        recipeTitleLabel.text = name
        timeLabel.text = "\(time) min"
        yieldLabel.text = yield
        recipeImageView.downloaded(from: image)

        navigationController?.navigationBar.setBackButtonTitle()
    }
    
    @IBAction func didTapGetDirectionButton(_ sender: Any) {
    }
}

extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientListCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        
        cell.ingredientLabel.text = "- \(ingredient)"
        
        return cell
    }
}
