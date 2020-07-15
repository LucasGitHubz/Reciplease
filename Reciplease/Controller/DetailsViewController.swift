//
//  DetailsViewController.swift
//  Reciplease
//
//  Created by kuroro on 22/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class DetailsViewController: CustomViewController {
    struct StarItemColor {
        let grey = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        let green = #colorLiteral(red: 0.2358415127, green: 0.5858561397, blue: 0.3734640479, alpha: 1)
    }
    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var getDirectionButton: CustomButton!
    @IBOutlet weak var starImage: UIImageView!

    // MARK: Properties
    var datas = Datas()
    
    // MARK: Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfRecipeAlreadyAddedToFavorite(datas.name)
        recipeTitleLabel.text = datas.name
        timeLabel.text = "\(datas.time) min"
        yieldLabel.text = datas.yield
        recipeImageView.downloaded(from: datas.image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfRecipeAlreadyAddedToFavorite(datas.name)
    }
    
    // MARK: Methods
    private func toogleActivityIndicator(shown: Bool) {
            getDirectionButton.isHidden = !shown
            starImage.isHidden = !shown
            activityIndicator.isHidden = shown
    }

    private func checkIfRecipeAlreadyAddedToFavorite(_ name: String) {
        // If allRecipesData is empty, then starImage's color pass to grey
        guard RecipeData.allRecipesData.count > 0 else {
            starImage.tintColor = StarItemColor.init().grey
            return
        }
        // Else, if the recipe's name is already saved in allRecipesData tab, then change to green the starImage's color
        for index in 0...RecipeData.allRecipesData.count - 1 where RecipeData.allRecipesData[index].name == name {
            starImage.tintColor = StarItemColor.init().green
        }
    }
    
    private func addRecipeToFavoriteOrDelete() {
        if starImage.tintColor == StarItemColor.init().green {
            RecipeData.deleteRecipeData(datas.name)
            starImage.tintColor = StarItemColor.init().grey
        } else {
            RecipeData.saveRecipeData(datas: datas)
            starImage.tintColor = StarItemColor.init().green
        }
    }
    
    // MARK: IBAction
    @IBAction func didTapOnStarButton(_ sender: Any) {
        toogleActivityIndicator(shown: false)
        addRecipeToFavoriteOrDelete()
        toogleActivityIndicator(shown: true)
    }
    
    @IBAction func didTapGetDirectionButton(_ sender: Any) {
    }
}

// MARK: TableView gestion
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientListCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = datas.ingredients[indexPath.row]
        
        cell.ingredientLabel.text = "- \(ingredient)"
        
        return cell
    }
}
