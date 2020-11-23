//
//  MapVCViewController.swift
//  Geo
//
//  Created by Радмир Юмагужин on 23.11.2020.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let location = CLLocationManager()
    
    struct Points {
        var lat = 0.0
        var lon = 0.0
        var name = ""
    }
    
    var pointsArray = [Points]()
    
    func pointsPositionalCollege(){
        let arrayLat = [55.818176, 55.844996, 55.860595, 55.860337]
        let arrayLon = [37.496261, 37.520960, 37.492089, 37.517689]
        let arraName = ["ЦИКТ", "ЦПиРБ", "ЦАВТ", "ЦТЭК"]
        
        for number in 0..<arrayLat.count {
            pointsArray.append(Points(lat: arrayLat[number], lon: arrayLon[number], name: arraName[number]))
        }
    }
    
    func pointPositions(){
        for number in 0..<pointsArray.count{
            let point = MKPointAnnotation()
            point.title = pointsArray[number].name
            point.coordinate = CLLocationCoordinate2D(latitude: pointsArray[number].lat, longitude: pointsArray[number].lon)
            mapView.addAnnotation(point)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        location.delegate = self
        mapView.delegate = self
        
        location.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        mapView.userLocation.title = "Я тута =)"
        mapView.userLocation.subtitle = "Вы нашли меня =)"
        
        pointPositions()
    }
    
    func mapView(_ mapView: MKMapView, vieFor annatation: MKAnnotation) -> MKAnnotationView? {
        if annatation.coordinate.latitude != mapView.userLocation.coordinate.latitude && annatation.coordinate.longitude != mapView.userLocation.coordinate.longitude{
            let marker = MKMarkerAnnotationView(annotation: annatation, reuseIdentifier: "marker")
            
            marker.canShowCallout = true
            let infobutton = UIButton(type: .detailDisclosure)
            infobutton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
            return marker
        }
        return nil
    }
    
    @objc func infoAction(){
        print("Info")
    }
    
    func mapToCoordinate(coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last?.coordinate{
            mapToCoordinate(coordinate: location)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
