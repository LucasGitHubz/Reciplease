//
//  CustomButton.swift
//  Reciplease
//
//  Created by kuroro on 23/06/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDesign()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setDesign()
    }

    func setDesign() {
        self.layer.cornerRadius = 5
    }
}
