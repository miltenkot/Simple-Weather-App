//
//  ViewController.swift
//  Simple Weather App
//
//  Created by Bartek Lanczyk on 03.12.2017.
//  Copyright © 2017 miltenkot. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_ID = "e7a6eda3asdyas8da7eaea"
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    //MARK: - Location Manager Delegate methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            
            locationManager.stopUpdatingLocation()
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            print("long: \(longitude)   lati: \(latitude)")
            let params :[String :  String] = ["lat" : latitude, "lon" : longitude, "appid" : API_ID]
            
        }
        else{
            print("Gówno nie udało się")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
   
    //MARK: - Networking
    /*****************************************************/
    


}

