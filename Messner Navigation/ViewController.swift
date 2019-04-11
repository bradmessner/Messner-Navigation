//
//  ViewController.swift
//  Messner Navigation
//
//  Created by Brad D. Messner on 4/2/19.
//  Copyright © 2019 Brad D. Messner. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var distanceLabel: UILabel!
    

    let locMan: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    let kshuLatitude: CLLocationDegrees = 40.3114
    let kshuLongitude: CLLocationDegrees = -79.5567
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: CLLocation=locations[0]
        NSLog("Something is happening")
        
        // horizontal accuracy less than than 0 means failure at gps level
        if newLocation.horizontalAccuracy >= 0 {
            let shu:CLLocation = CLLocation(latitude: kshuLatitude,longitude: kshuLongitude)
            let delta:CLLocationDistance = shu.distance(from: newLocation)
            let miles: Double = (delta * 0.000621371) + 0.5 // meters to rounded miles
            if miles < 3 {
                // Stop updating the location
                locMan.stopUpdatingLocation()
                // Congratulate the user
                distanceLabel.text = "Enjoy\nSeton Hill University!"
            } else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to SHU"
            }
            //waitView.isHidden = true
            //distanceView.isHidden = false
        }
        // oldLocation=locations[0] as CLLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //waitView.isHidden = true
        //distanceView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter = 1609; // a mile
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        startLocation = nil
    }


}

