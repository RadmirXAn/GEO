//
//  ViewController.swift
//  Geo
//
//  Created by Радмир Юмагужин on 23.11.2020.
//

import UIKit
import CoreLocation

class LocationVC: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var dataLet: UILabel!
    @IBOutlet weak var dataLon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkAutorization()
    }

    func checkAutorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            print("Error")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last?.coordinate{
            dataLet.text = String(location.latitude)
            dataLon.text = String(location.longitude)
            locationManager.startUpdatingLocation()
        }
    }

}

