//
//  SettingViewController.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/15/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsChanged(distanceUnits: String, bearingUnits: String)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    var selectedLabel: UILabel! = nil;
    
    var bearingUnits = ["Degrees", "Mils"]
    var distanceUnits = ["Kilometers", "Miles"]
    
    var currentPickerList:[String] = [String]();
    var selection: String = ""
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Distance label tapped
        let distanceTapped = UITapGestureRecognizer(target: self, action: #selector(distanceLabelTapped))
        distanceLabel.addGestureRecognizer(distanceTapped)
        
        // Bearing label tapped
        let bearingTapped = UITapGestureRecognizer(target: self, action: #selector(bearingLabelTapped))
        bearingLabel.addGestureRecognizer(bearingTapped)
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.hidePicker))
        self.view.addGestureRecognizer(detectTouch)
        
        self.currentPickerList = self.bearingUnits;
        self.picker.isHidden = true;
        self.picker.dataSource = self;
        self.picker.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func distanceLabelTapped() {
        self.selectedLabel = self.distanceLabel;
        self.currentPickerList = self.distanceUnits;
        picker.isHidden = false;
        picker.dataSource = self;
        
        picker.selectRow(currentPickerList.index(of: selectedLabel.text!)!, inComponent: 0, animated: true)
    }
    
    @objc func bearingLabelTapped() {
        self.selectedLabel = self.bearingLabel;
        self.currentPickerList = self.bearingUnits;
        picker.isHidden = false;
        picker.dataSource = self;
        
        picker.selectRow(currentPickerList.index(of: selectedLabel.text!)!, inComponent: 0, animated: true)
    }
    
    @objc func hidePicker() {
        picker.isHidden = true;
    }
}

extension SettingViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return currentPickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.currentPickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedLabel.text = self.currentPickerList[row]
    }
}
