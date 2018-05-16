//
//  BearingPickerView.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/15/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

class BearingPickerView: UIPickerView {

    var bearingUnits = ["Degrees", "Mils"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bearingUnits.count;
    }
    
}
