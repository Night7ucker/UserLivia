//
//  GoogleMapViewController.swift
//  User
//
//  Created by BAMFAdmin on 02.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMapViewController: RootViewController {

    var firstLocationUpdate: Bool?
    var locationManager = CLLocationManager()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var currentPinLocation: CLLocationCoordinate2D!
    var userCurrentLocation: CLLocationCoordinate2D!
    
    @IBOutlet var setDeliveryPlaceMapView: GMSMapView!

    @IBOutlet weak var topMajorViewOutlet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Select location")
        topMajorViewOutlet.backgroundColor = Colors.Root.greenColorForNavigationBar
        userCurrentLocation = CLLocationCoordinate2D(latitude: 53.918509, longitude: 27.590219)
        currentPinLocation = userCurrentLocation
        
        
        setDeliveryPlaceMapView.delegate = self
        setDeliveryPlaceMapView.isMyLocationEnabled = true
        
        let newPinLocation = GMSCameraPosition.camera(withLatitude: userCurrentLocation.latitude,
                                                      longitude: userCurrentLocation.longitude,
                                                      zoom: 15)
        setDeliveryPlaceMapView.animate(to: newPinLocation)
        
        let infoMarker = PlaceMarker(place: currentPinLocation)
        infoMarker.map = setDeliveryPlaceMapView
        
        setDeliveryPlaceMapView.selectedMarker = infoMarker
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let testButton = UIButton()
        testButton.frame = CGRect(x: 35, y: 620, width: 300, height: 30)
        testButton.setTitle("Delivery at my current location", for: .normal)
        testButton.layer.zPosition = 4
        testButton.layer.cornerRadius = 2
        testButton.addTarget(self, action: #selector(testButtonTapped(_:)), for: .touchUpInside)
        testButton.titleLabel?.font = testButton.titleLabel?.font.withSize(13)
        testButton.backgroundColor = Colors.Root.lightBlueColor
        testButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(testButton)
        
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
        
        viewForCurrentLocationButton.addSubview(buttonForCurrentPosition)
        
        view.addSubview(viewForCurrentLocationButton)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.searchBarStyle = .minimal
        searchController?.searchBar.backgroundColor = .white
        
        let subView = UIView(frame: CGRect(x: 0, y: 112, width: view.frame.width, height: 33))
        
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        definesPresentationContext = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func currentLocationButtonTapped(_ sender: UIButton) {
        setDeliveryPlaceMapView.clear()
        let newPinLocation = GMSCameraPosition.camera(withLatitude: userCurrentLocation.latitude,
                                                      longitude: userCurrentLocation.longitude,
                                                      zoom: setDeliveryPlaceMapView.camera.zoom)
        setDeliveryPlaceMapView.animate(to: newPinLocation)
        
        let currentLocation = CLLocationCoordinate2D(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude)
        let infoMarker = PlaceMarker(place: currentLocation)
        infoMarker.map = setDeliveryPlaceMapView
        
        setDeliveryPlaceMapView.selectedMarker = infoMarker
        currentPinLocation = currentLocation
    }
    
    func testButtonTapped(_ sender: UIButton) {
        print("test button tapped")
    }

}

extension GoogleMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let calloutView = UIView()
        calloutView.frame = CGRect(x: 0, y: 0, width: 145, height: 25)
        calloutView.layer.cornerRadius = 3
        calloutView.backgroundColor = .white
        
        let calloutViewLabel = UILabel()
        calloutViewLabel.text = "Set Delivery Location >"
        calloutViewLabel.textColor = Colors.Root.lightBlueColor
        calloutViewLabel.font = calloutViewLabel.font.withSize(12)
        calloutViewLabel.frame = CGRect(x: 5, y: 3, width: 140, height: 20)
        
        calloutView.addSubview(calloutViewLabel)
        
        return calloutView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        currentPinLocation = marker.position
        print(currentPinLocation)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        
        let newPinLocation = GMSCameraPosition.camera(withLatitude: coordinate.latitude,
                                              longitude: coordinate.longitude,
                                              zoom: mapView.camera.zoom)
        mapView.animate(to: newPinLocation)
        
        
        let infoMarker = PlaceMarker(place: coordinate)
        infoMarker.map = mapView
        
        mapView.selectedMarker = infoMarker
        currentPinLocation = coordinate
    }
}

extension GoogleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: setDeliveryPlaceMapView.camera.zoom)
        
        setDeliveryPlaceMapView.animate(to: camera)
        
    }
}

extension GoogleMapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        
        setDeliveryPlaceMapView.clear()
        
        let newPinLocation = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                                      longitude: place.coordinate.longitude,
                                                      zoom: 20)
        setDeliveryPlaceMapView.animate(to: newPinLocation)
        
        
        let infoMarker = PlaceMarker(place: place.coordinate)
        infoMarker.map = setDeliveryPlaceMapView
        
        setDeliveryPlaceMapView.selectedMarker = infoMarker
        currentPinLocation = place.coordinate
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

