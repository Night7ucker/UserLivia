//
//  OrderMapTableViewCell.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class OrderMapTableViewCell: UITableViewCell, GMSMapViewDelegate {

    @IBOutlet weak var orderMapViewOutlet: GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        orderMapViewOutlet.delegate = self
        
        let newPinLocation = GMSCameraPosition.camera(withLatitude: CoordinateSingletone.sharedInstance.currentPinLocation.latitude,
                                                      longitude: CoordinateSingletone.sharedInstance.currentPinLocation.longitude,
                                                      zoom: 15)
        orderMapViewOutlet.animate(to: newPinLocation)
        
        let infoMarker = PlaceMarker(place: CoordinateSingletone.sharedInstance.currentPinLocation)
        infoMarker.map = orderMapViewOutlet
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
