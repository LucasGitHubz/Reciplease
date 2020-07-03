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
    @IBOutlet weak var starImage: UIImageView!
    
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

    private func changeStarItemColor() {
        if starImage.tintColor == #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1) {
            starImage.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        } else {
            starImage.tintColor = #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1)
        }
    }

    private func saveTest(test name: String) {
        let test = Favorites(context: AppDelegate.viewContext)
        test.test = name
        try? AppDelegate.viewContext.save()
    }

    @IBAction func didTapOnStarButton(_ sender: Any) {
        changeStarItemColor()

        saveTest(test: name)
        // To do list:
        // Add recipe's informations to a "favorite" tab if it's not already added
        // If it's already added, delete it
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
