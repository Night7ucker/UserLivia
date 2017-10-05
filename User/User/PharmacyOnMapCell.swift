//
//  PharmacyOnMapCell.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PharmacyOnMapCell: UITableViewCell, GMSMapViewDelegate {
    
    var pharmacyLocation: CLLocationCoordinate2D!
    
    @IBOutlet weak var pharmacyOnMapViewOutlet: GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pharmacyOnMapViewOutlet.delegate = self
        
        pharmacyLocation = CLLocationCoordinate2D(latitude: Double(RealmDataManager.getOrderDrugsDescriptionModel()[0].pLat!)!, longitude: Double(RealmDataManager.getOrderDrugsDescriptionModel()[0].pLong!)!)
        
        let pharmacyMarker = PlaceMarker(place: pharmacyLocation)
        pharmacyMarker.map = pharmacyOnMapViewOutlet
        
        let cameraOnCurrentLocation = GMSCameraPosition.camera(withLatitude: pharmacyLocation.latitude,
                                                               longitude: pharmacyLocation.longitude,
                                                               zoom: 10)
        pharmacyOnMapViewOutlet.animate(to: cameraOnCurrentLocation)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
