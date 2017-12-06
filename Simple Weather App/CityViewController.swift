//
//  CityViewController.swift
//  Simple Weather App
//
//  Created by Bartek Lanczyk on 03.12.2017.
//  Copyright © 2017 miltenkot. All rights reserved.
//

import UIKit

protocol ChangeCityName {
    func userEnteredNewCityName(city: String)
}

class CityViewController: UIViewController {
    
    
    //MARK: - Properties
    /**********************************************/
    
    var delegate : ChangeCityName?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - Actions
    /**********************************************/
    
    @IBAction func acceptCityButton(_ sender: UIButton) {
        
        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredNewCityName(city: cityName )
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

    

}
