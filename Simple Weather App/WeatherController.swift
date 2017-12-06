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
import SwiftyJSON



class WeatherController: UIViewController, CLLocationManagerDelegate,ChangeCityName {
    
    
    
    //MARK: - Properties
    /**********************************************/
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var degreeLabel: UILabel!
    
    var delegate : ChangeCityName?
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_ID = "9c4d2fbd0da6b6b38c9c64b9c9c48d19"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    //MARK: - Location Manager Delegate methods
    /**********************************************/

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
          
            let params :[String :  String] = ["lat" : latitude, "lon" : longitude, "appid" : API_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
            
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
    func getWeatherData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                self.updateUIWithWeatherData()
                
            }
                
            else {
                print(response.result.error!)
            }
        }
    }
    //MARK: - JSON Parsing
    /**********************************************/
    
    func updateWeatherData(json: JSON){
        
    
        if let temp = json["main"]["temp"].double{
            weatherDataModel.temperature = Int(temp - 273.15)
            weatherDataModel.city =  json["name"].stringValue
            weatherDataModel.condition =  json["weather"][0]["id"].intValue
        }
        else {
            cityNameLabel.text = "Weather Unavailable"
        }
        
    }
    
    //MARK: - UI Updates
    /**********************************************/
    
    func updateUIWithWeatherData(){
        cityNameLabel.text = String(weatherDataModel.city)
        degreeLabel.text = String(weatherDataModel.temperature)
        
        
    }
    
    //MARK: Change City Deleate methods
    /**********************************************/
    
    func userEnteredNewCityName(city: String) {
        
        let params :[String :  String] = ["q" : city, "appid" : API_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! CityViewController
            destinationVC.delegate = self
        }
    }


}

