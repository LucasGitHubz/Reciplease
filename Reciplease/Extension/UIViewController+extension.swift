//
//  UIViewController+extension.swift
//  Reciplease
//
//  Created by kuroro on 26/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

extension UIViewController {
    struct AlertMessage {
        let programError = "L'application n'a pas pu récupérer les données nécessaires. Vérifiez que vous êtes bien connecté(e) à internet"
        let emptyTextFieldError = "Veuillez écrire le nom d'un ingrédient avant d'ajouter à la liste."
        let emptyListError = "Veuillez renseigner vos ingrédients avant de lancer une recherche."
    }

    func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error",
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
