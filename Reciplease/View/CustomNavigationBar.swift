//
//  CustomNavigationBar.swift
//  Reciplease
//
//  Created by kuroro on 26/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
    }
    
    func setDesign() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 20) as Any]
        UINavigationBar.appearance().titleTextAttributes = attributes
            let barButton = UIBarButtonItem()
            barButton.title = "back"
            barButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 20) as Any], for: UIControl.State.normal)
        self.topItem?.backBarButtonItem = barButton
    }
}
