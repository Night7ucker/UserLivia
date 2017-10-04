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
        let coordinates = CLLocationCoordinate2D(latitude: Double(RealmDataManager.getSendingOrderFromRealm()[0].latitude!)!, longitude: Double(RealmDataManager.getSendingOrderFromRealm()[0].longtitude!)!)
        
        
        let newPinLocation = GMSCameraPosition.camera(withLatitude: coordinates.latitude,
                                                      longitude: coordinates.longitude,
                                                      zoom: 15)
        orderMapViewOutlet.animate(to: newPinLocation)
        
        let infoMarker = PlaceMarker(place: coordinates)
        infoMarker.map = orderMapViewOutlet
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
