//
//  UINavigationBar+extension.swift
//  Reciplease
//
//  Created by kuroro on 02/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setBackButtonTitle() {
        let barButton = UIBarButtonItem()
        barButton.title = "back"
        barButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 20) as Any], for: UIControl.State.normal)
        self.topItem?.backBarButtonItem = barButton
    }
}
