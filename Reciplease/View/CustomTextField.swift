//
//  CustomTextField.swift
//  Reciplease
//
//  Created by kuroro on 26/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
    }

    func setDesign() {
        self.layer.shadowColor = #colorLiteral(red: 0.7803768516, green: 0.7803367972, blue: 0.7889209986, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 1
    }
}
