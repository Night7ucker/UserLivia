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
import RealmSwift

protocol PharmacyInfoViewControllerDelegate {
    func sentDelegateToPushToMainPageController(pharmacyID: String)
}

class GoogleMapViewController: RootViewController, PharmacyInfoViewControllerDelegate {
    
    var firstLocationUpdate: Bool?
    var locationManager = CLLocationManager()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    var currentPinLocation: CLLocationCoordinate2D!
    var userCurrentLocation: CLLocationCoordinate2D!
    
    var isPaged = true
    var delegate: GoogleMapViewControllerDelegate!
    
    @IBOutlet var setDeliveryPlaceMapView: GMSMapView!
    
    @IBOutlet weak var topMajorViewOutlet: UIView!
    
    @IBOutlet weak var enterAddressLabelOutlet: UILabel!
    
    @IBOutlet weak var googleMapTopConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.barTintColor = Colors.Root.greenColorForNavigationBar
        
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
        if isPaged == false {
            let infoMarker = PlaceMarker(place: currentPinLocation)
            infoMarker.map = setDeliveryPlaceMapView
            
            setDeliveryPlaceMapView.selectedMarker = infoMarker
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 500
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if isPaged == false {
            let deliverAtMyCurrentLocation = UIButton()
            deliverAtMyCurrentLocation.setTitle("Deliver at my current location", for: .normal)
            deliverAtMyCurrentLocation.layer.zPosition = 4
            deliverAtMyCurrentLocation.layer.cornerRadius = 2
            deliverAtMyCurrentLocation.addTarget(self, action: #selector(deliveryButtonTapped(_:)), for: .touchUpInside)
            deliverAtMyCurrentLocation.titleLabel?.font = deliverAtMyCurrentLocation.titleLabel?.font.withSize(13)
            deliverAtMyCurrentLocation.backgroundColor = Colors.Root.lightBlueColor
            deliverAtMyCurrentLocation.setTitleColor(.white, for: .normal)
            
            
            view.addSubview(deliverAtMyCurrentLocation)
            
            deliverAtMyCurrentLocation.frame = CGRect(x: 35, y: 620, width: 300, height: 30)
        }
        
        
        let viewForCurrentLocationButton = UIView()
        if isPaged {
            enterAddressLabelOutlet.isHidden = true
            topMajorViewOutlet.isHidden = true
            googleMapTopConstraint.constant = 0
            viewForCurrentLocationButton.frame = CGRect(x: 330, y: 100, width: 35, height: 35)
        } else {
            viewForCurrentLocationButton.frame = CGRect(x: 330, y: 160, width: 35, height: 35)
        }
        
        viewForCurrentLocationButton.layer.cornerRadius = 2
        viewForCurrentLocationButton.layer.opacity = 0.5
        viewForCurrentLocationButton.backgroundColor = .white
        
        let buttonForCurrentPosition = UIButton()
        buttonForCurrentPosition.frame = CGRect(x: 0, y: 0, width: viewForCurrentLocationButton.frame.width, height: viewForCurrentLocationButton.frame.height)
        buttonForCurrentPosition.setBackgroundImage(UIImage(named: "currentLocation"), for: .normal)
        buttonForCurrentPosition.backgroundColor = .white
        buttonForCurrentPosition.addTarget(self, action: #selector(currentLocationButtonTapped(_ :)), for: .touchUpInside)
        
        if isPaged {
//            enterAddressLabelOutlet.isHidden = true
//            topMajorViewOutlet.backgroundColor = Colors.Root.lightGrayColor
//            let searchLabelIcon = UILabel()
//            searchLabelIcon.text = "🔍"
//            searchLabelIcon.font = UIFont.systemFont(ofSize: 20)
//            searchLabelIcon.frame = CGRect(x: 10, y: 33, width: 30, height: 33)
//            
//            let searchTextField = UITextField()
//            searchTextField.borderStyle = .none
//            searchTextField.frame = CGRect(x: 50, y: 33, width: view.frame.width - 50, height: 33)
//            searchTextField.placeholder = "Enter pharmacy name"
////            searchTextField.delegate = self
//            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//            
//            view.addSubview(searchLabelIcon)
//            view.addSubview(searchTextField)
        } else {
            viewForCurrentLocationButton.addSubview(buttonForCurrentPosition)
            
            view.addSubview(viewForCurrentLocationButton)
            
            resultsViewController = GMSAutocompleteResultsViewController()
            resultsViewController?.delegate = self
            
            searchController = UISearchController(searchResultsController: resultsViewController)
            searchController?.searchResultsUpdater = resultsViewController
            searchController?.searchBar.searchBarStyle = .minimal
            searchController?.searchBar.backgroundColor = .white
            
            let subView = UIView()
            subView.frame = CGRect(x: 0, y: 112, width: view.frame.width, height: 33)
            
            
            subView.addSubview((searchController?.searchBar)!)
            
            
            view.addSubview(subView)
            
            searchController?.searchBar.sizeToFit()
            searchController?.hidesNavigationBarDuringPresentation = false
        }
        
        
        
        
        definesPresentationContext = true
        
        if isPaged {
            let choosedLocation = CLLocationCoordinate2D(latitude: Double(RealmDataManager.getSendingOrderFromRealm()[0].latitude!)!, longitude: Double(RealmDataManager.getSendingOrderFromRealm()[0].longtitude!)!)
            print(choosedLocation)
            //            let choosedLocation = CLLocationCoordinate2D(latitude: 53.9181001, longitude: 27.590105)
            let realm = try! Realm()
            if RealmDataManager.getPharmaciesFromRealm().count != 0 {
                try! realm.write {
                    realm.delete(RealmDataManager.getPharmaciesFromRealm())
                }
            }
            GetPharmaciesRequest.getPharmacies(coordinate: choosedLocation) { success in
                if success {
                    self.addPinsOnPharmaciesCoordinates()
                }
            }
            
            //            let pharmaciesArray = RealmDataManager.getPharmaciesFromRealm()
            //            for i in 0..<pharmaciesArray.count {
            //                let infoMarker = PlaceMarker(place: CLLocationCoordinate2D(latitude: Double(pharmaciesArray[i].latitude!)!, longitude: Double(pharmaciesArray[i].longtitude!)!))
            //                infoMarker.map = setDeliveryPlaceMapView
            //            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sentDelegateToPushToMainPageController(pharmacyID: String) {
        delegate.pushToReviewOrderVC(pharmacyID: pharmacyID)
    }
    
//    func textFieldDidChange(_ textField: UITextField) {
//        let searchHelpView = UIView()
//        searchHelpView.frame = CGRect(x: view.frame.width/2 - 50, y: 100, width: 100, height: 70)
//        
//        let searchPharmacyText = UILabel()
//        searchPharmacyText.frame = CGRect(x: 15, y: 15, width: 90, height: 20)
//        searchPharmacyText.text = getPharmacyNameBySearchString(searchString: textField.text!)
//        
//        searchHelpView.addSubview(searchPharmacyText)
//        
//        view.addSubview(searchHelpView)
//    }
    
    func addPinsOnPharmaciesCoordinates() {
        for i in 0..<RealmDataManager.getPharmaciesFromRealm().count {
            let pharmacyCoordinates = CLLocationCoordinate2D(latitude: Double(RealmDataManager.getPharmaciesFromRealm()[i].latitude!)!, longitude: Double(RealmDataManager.getPharmaciesFromRealm()[i].longtitude!)!)
            let infoMarker = PlaceMarker(place: pharmacyCoordinates)
            infoMarker.title = RealmDataManager.getPharmaciesFromRealm()[i].userId
            infoMarker.map = setDeliveryPlaceMapView
        }
    }
    
    @objc func currentLocationButtonTapped(_ sender: UIButton) {
        if isPaged == false {
            setDeliveryPlaceMapView.clear()
        }
        let newPinLocation = GMSCameraPosition.camera(withLatitude: userCurrentLocation.latitude,
                                                      longitude: userCurrentLocation.longitude,
                                                      zoom: setDeliveryPlaceMapView.camera.zoom)
        setDeliveryPlaceMapView.animate(to: newPinLocation)
        if isPaged == false {
            let currentLocation = CLLocationCoordinate2D(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude)
            let infoMarker = PlaceMarker(place: currentLocation)
            infoMarker.map = setDeliveryPlaceMapView
            
            setDeliveryPlaceMapView.selectedMarker = infoMarker
            currentPinLocation = currentLocation
        }
        
    }
    
    @objc func deliveryButtonTapped(_ sender: UIButton) {
        if Int(RealmDataManager.getSendingOrderFromRealm()[0].manual!)! == 1 {
            let objectToWriteCoordinates = RealmDataManager.getSendingOrderFromRealm()[0]
            let realm = try! Realm()
            try! realm.write {
                objectToWriteCoordinates.latitude = String(currentPinLocation.latitude)
                objectToWriteCoordinates.longtitude = String(currentPinLocation.longitude)
            }
            
            let googleMapStoryboard = UIStoryboard(name: "GoogleMap", bundle: nil)
            let googleMapViewController = googleMapStoryboard.instantiateViewController(withIdentifier: "kPageMapAndPharmacyVC") as? PageMapAndPharmacyVC
            navigationController?.pushViewController(googleMapViewController!, animated: false)
        } else {
            let objectToWriteCoordinates = RealmDataManager.getSendingOrderFromRealm()[0]
            let realm = try! Realm()
            try! realm.write {
                objectToWriteCoordinates.latitude = String(currentPinLocation.latitude)
                objectToWriteCoordinates.longtitude = String(currentPinLocation.longitude)
            }
            let reviewYourOrder = UIStoryboard(name: "ReviewYourOrder", bundle: nil)
            let reviewYourOrderViewController = reviewYourOrder.instantiateViewController(withIdentifier: "kReviewYourOrdedViewController") as! ReviewYourOrdedViewController
            navigationController?.pushViewController(reviewYourOrderViewController, animated: false)
        }
    }
    
}

extension GoogleMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        if isPaged == false {
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
        return UIView()
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if isPaged {
            let googleMapStoryboard = UIStoryboard(name: "GoogleMap", bundle: nil)
            let pharmacyInfoPopupViewController = googleMapStoryboard.instantiateViewController(withIdentifier: "kPharmacyInfoViewController") as! PharmacyInfoViewController
            pharmacyInfoPopupViewController.tappedPharmacyId = marker.title
            pharmacyInfoPopupViewController.delegate = self
            present(pharmacyInfoPopupViewController, animated: false, completion: nil)
            return true
        }
        return false
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if isPaged == false {
            currentPinLocation = marker.position
            if Int(RealmDataManager.getSendingOrderFromRealm()[0].manual!)! == 1 {
                let objectToWriteCoordinates = RealmDataManager.getSendingOrderFromRealm()[0]
                let realm = try! Realm()
                try! realm.write {
                    objectToWriteCoordinates.latitude = String(currentPinLocation.latitude)
                    objectToWriteCoordinates.longtitude = String(currentPinLocation.longitude)
                }
                
                let googleMapStoryboard = UIStoryboard(name: "GoogleMap", bundle: nil)
                let googleMapViewController = googleMapStoryboard.instantiateViewController(withIdentifier: "kPageMapAndPharmacyVC") as? PageMapAndPharmacyVC
                navigationController?.pushViewController(googleMapViewController!, animated: false)
            } else {
                let objectToWriteCoordinates = RealmDataManager.getSendingOrderFromRealm()[0]
                let realm = try! Realm()
                try! realm.write {
                    objectToWriteCoordinates.latitude = String(currentPinLocation.latitude)
                    objectToWriteCoordinates.longtitude = String(currentPinLocation.longitude)
                }
                let reviewYourOrder = UIStoryboard(name: "ReviewYourOrder", bundle: nil)
                let reviewYourOrderViewController = reviewYourOrder.instantiateViewController(withIdentifier: "kReviewYourOrdedViewController") as! ReviewYourOrdedViewController
                navigationController?.pushViewController(reviewYourOrderViewController, animated: false)
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if isPaged == false {
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
    
    func getPharmacyNameBySearchString(searchString: String) -> String? {
        for pharmacy in RealmDataManager.getPharmaciesFromRealm() {
            if (pharmacy.pharmacyName?.contains(searchString))! {
                return pharmacy.pharmacyName!
            }
        }
        return nil
        
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
//
//extension GoogleMapViewController: UITextFieldDelegate  {
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//    }
//}


