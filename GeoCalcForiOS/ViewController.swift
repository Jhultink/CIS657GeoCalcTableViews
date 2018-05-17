//
//  ViewController.swift
//  GeoCalcForiOS
//
//  Created by BDO on 5/15/18.
//  Copyright © 2018 Jaredt. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, SettingsViewControllerDelegate {
    
    @IBOutlet weak var latitudeP1: DecimalMinusTextField!
    @IBOutlet weak var latitudeP2: DecimalMinusTextField!
    @IBOutlet weak var longitudeP1: DecimalMinusTextField!
    @IBOutlet weak var longitudeP2: DecimalMinusTextField!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    var bearingUnit = "Degrees"
    var distanceUnit = "Kilometers"
    
    var distanceInKilometers:Double?
    var bearingInDegrees:Double?
    
    @IBAction func calculatePressed(_ sender: Any) {
        calculateDistanceAndBearing()
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        latitudeP1.text = ""
        latitudeP2.text = ""
        longitudeP1.text = ""
        longitudeP2.text = ""
        
        distanceLabel.text = "Distance: "
        bearingLabel.text = "Bearing: "
        
        distanceInKilometers = nil
        bearingInDegrees = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateDistanceAndBearing() {
        guard let latP1 = latitudeP1.text, let latP2 = latitudeP2.text, let lonP1 = longitudeP1.text, let lonP2 = longitudeP2.text else {
            
            let alert = UIAlertController(title: "Invalid value", message: "Please enter values for all fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return;
        }
        
        guard let latP1Dbl = Double(latP1), let latP2Dbl = Double(latP2), let lonP1Dbl = Double(lonP1), let lonP2Dbl = Double(lonP2) else {
            
            let alert = UIAlertController(title: "Invalid value", message: "Please enter valid values for all fields", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return;
        }
        
        let p1 = CLLocation(latitude: latP1Dbl, longitude: lonP1Dbl)
        let p2 = CLLocation(latitude: latP2Dbl, longitude: lonP2Dbl)
        
        let distanceInMeters = p1.distance(from: p2)
        print(distanceInMeters)
        
<<<<<<< HEAD
        distanceLabel.text = "Distance: " + String(format: "%.2f", distanceInMeters / 1000)
        
        bearingLabel.text = "Bearing: " + String(format: "%.2f", RadiansToDegrees(radians: Double(getBearing(fromLoc: p2, toLoc: p1))))
        
        
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        
        latitudeP1.text = ""
        latitudeP2.text = ""
        longitudeP1.text = ""
        longitudeP2.text = ""
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
=======
        self.distanceInKilometers = (distanceInMeters / 1000)
        self.bearingInDegrees = RadiansToDegrees(radians: Double(getBearing(fromLoc: p2, toLoc: p1)))
    
        redrawLabels()
    }
    
    func redrawLabels() {
        guard let dist = self.distanceInKilometers, let bear = self.bearingInDegrees else {
            return
        }
        
        var recalculatedDist = dist
        var recalculatedBearing = bear
        
        if (self.bearingUnit == "Mils") {
            recalculatedBearing *= 17.7777777778
        }
        
        if (self.distanceUnit == "Miles") {
            recalculatedDist *= 0.621371
        }
        
        distanceLabel.text = "Distance: " + String(format: "%.2f", recalculatedDist) + " " + distanceUnit
        bearingLabel.text = "Bearing: " + String(format: "%.2f", recalculatedBearing) + " " + bearingUnit
>>>>>>> b2d856d9d175c98dfde2dbe012a3c4d454eab4ce
    }
    
    func d2r(degrees : Double) -> Double {
        return degrees * M_PI / 180.0
    }
    
    func RadiansToDegrees(radians : Double) -> Double {
        return radians * 180.0 / M_PI
    }
    
    func getBearing(fromLoc : CLLocation, toLoc : CLLocation) -> CGFloat {
        
        let fLat = d2r(degrees: fromLoc.coordinate.latitude)
        let fLng = d2r(degrees: fromLoc.coordinate.longitude)
        let tLat = d2r(degrees: toLoc.coordinate.latitude)
        let tLng = d2r(degrees: toLoc.coordinate.longitude)
        
        var a = CGFloat(sin(fLng-tLng)*cos(tLat));
        var b = CGFloat(cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(fLng-tLng))
        
        return atan2(a,b)
    }
    
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        self.bearingUnit = bearingUnits
        self.distanceUnit = distanceUnits
        redrawLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nav = segue.destination as? UINavigationController, let dest = nav.topViewController as? SettingViewController {
            dest.delegate = self
        }
    }
}

