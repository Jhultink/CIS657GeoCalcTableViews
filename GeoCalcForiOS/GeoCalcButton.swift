//
//  GeoCalcButton.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/22/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

class GeoCalcButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = FOREGROUND_COLOR
        self.tintColor = BACKGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
