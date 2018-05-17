//
//  SettingViewController.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/15/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
<<<<<<< HEAD

=======
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    var selectedLabel: UILabel! = nil;
    
    let distanceUnits = ["Kilometers", "Miles"]
    let bearingUnits = ["Degrees", "Mils"]
    
    var selectedDistance:String?
    var selectedBearing:String?
    
    var currentPickerList:[String] = [String]();
    //var selection: String = ""
    
    var delegate : SettingsViewControllerDelegate?
    
    @IBOutlet weak var picker: UIPickerView!
    
>>>>>>> b2d856d9d175c98dfde2dbe012a3c4d454eab4ce
    @IBAction func cancelPressed(_ sender: Any) {
        //navigationController!.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func savedPressed(_ sender: Any) {
        if let d = self.delegate {
            d.settingsChanged(distanceUnits: self.selectedDistance!, bearingUnits: self.selectedBearing!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD

        // Do any additional setup after loading the view.
=======
        
        self.selectedDistance = self.distanceUnits[0]
        self.selectedBearing = self.bearingUnits[0]
        
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
>>>>>>> b2d856d9d175c98dfde2dbe012a3c4d454eab4ce
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
<<<<<<< HEAD

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
=======
    @objc func distanceLabelTapped() {
        self.selectedLabel = self.distanceLabel;
        self.currentPickerList = self.distanceUnits;
        picker.isHidden = false;
        picker.dataSource = self;
        
        picker.selectRow(currentPickerList.index(of: self.selectedDistance!)!, inComponent: 0, animated: true)
    }
    
    @objc func bearingLabelTapped() {
        self.selectedLabel = self.bearingLabel;
        self.currentPickerList = self.bearingUnits;
        picker.isHidden = false;
        picker.dataSource = self
        
        picker.selectRow(currentPickerList.index(of: self.selectedBearing!)!, inComponent: 0, animated: true)
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
        
        if self.selectedLabel == self.bearingLabel {
            self.selectedBearing = self.currentPickerList[row]
        } else {
            self.selectedDistance = self.currentPickerList[row]
        }
>>>>>>> b2d856d9d175c98dfde2dbe012a3c4d454eab4ce
    }
    */

}
