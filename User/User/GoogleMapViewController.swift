//
//  GoogleMapViewController.swift
//  User
//
//  Created by BAMFAdmin on 02.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate {

    var firstLocationUpdate: Bool?
    

    
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 22.300000, longitude: 70.783300, zoom: 10.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.camera = camera
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        self.view = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
            
        {
            mapView.isMyLocationEnabled = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 12.0)
        mapView.settings.myLocationButton = true
        self.view = self.mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        marker.map = self.mapView
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

