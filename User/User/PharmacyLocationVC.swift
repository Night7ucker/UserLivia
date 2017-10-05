//
//  PharmacyLocationVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PharmacyLocationVC: RootViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var pharmacyMapView: GMSMapView!
    
    var userCurrentLocation: CLLocationCoordinate2D!
    var pharmacyLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Pharmacy Location")
        
        pharmacyMapView.delegate = self
        
        userCurrentLocation = CLLocationCoordinate2D(latitude: 53.918509, longitude: 27.590219)
        pharmacyLocation = CLLocationCoordinate2D(latitude: Double(RealmDataManager.getOrderDrugsDescriptionModel()[0].pLat!)!, longitude: Double(RealmDataManager.getOrderDrugsDescriptionModel()[0].pLong!)!)
        
        let currentLocationMarker = PlaceMarker(place: userCurrentLocation)
        currentLocationMarker.map = pharmacyMapView
        
        let pharmacyMarker = PlaceMarker(place: pharmacyLocation)
        pharmacyMarker.map = pharmacyMapView
        
        let cameraOnCurrentLocation = GMSCameraPosition.camera(withLatitude: userCurrentLocation.latitude,
                                                               longitude: userCurrentLocation.longitude,
                                                               zoom: 10)
        pharmacyMapView.animate(to: cameraOnCurrentLocation)
        
        let viewForCurrentLocationButton = UIView()
        
        viewForCurrentLocationButton.frame = CGRect(x: 330, y: 160, width: 35, height: 35)
        
        viewForCurrentLocationButton.layer.cornerRadius = 2
        viewForCurrentLocationButton.layer.opacity = 0.5
        viewForCurrentLocationButton.backgroundColor = .white
        
        let buttonForCurrentPosition = UIButton()
        buttonForCurrentPosition.frame = CGRect(x: 0, y: 0, width: viewForCurrentLocationButton.frame.width, height: viewForCurrentLocationButton.frame.height)
        buttonForCurrentPosition.setBackgroundImage(UIImage(named: "currentLocation"), for: .normal)
        buttonForCurrentPosition.backgroundColor = .white
        buttonForCurrentPosition.addTarget(self, action: #selector(currentLocationButtonTapped(_ :)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func currentLocationButtonTapped(_ sender: UIButton) {
        let cameraOnCurrentLocation = GMSCameraPosition.camera(withLatitude: userCurrentLocation.latitude,
                                                      longitude: userCurrentLocation.longitude,
                                                      zoom: pharmacyMapView.camera.zoom)
        pharmacyMapView.animate(to: cameraOnCurrentLocation)
    }
    
}
