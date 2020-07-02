//
//  StyleView.swift
//  Reciplease
//
//  Created by kuroro on 02/07/2020.
//  Copyright © 2020 lucasam. All rights reserved.
//

import UIKit

class StyleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyle()
    }

    func setStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = 5
    }
}
