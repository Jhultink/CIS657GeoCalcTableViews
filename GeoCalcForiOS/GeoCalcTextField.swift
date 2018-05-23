//
//  GeoCalcTextField.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/22/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

class GeoCalcTextField: DecimalMinusTextField {

    
    override func awakeFromNib() {
        self.tintColor = FOREGROUND_COLOR
        self.textColor = FOREGROUND_COLOR
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        self.borderStyle = .roundedRect
        
        self.backgroundColor = UIColor(white: 1, alpha: 0.0)
        
        guard let ph = self.placeholder else {
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: ph,
                                                               attributes: [NSAttributedStringKey.foregroundColor: FOREGROUND_COLOR])
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
