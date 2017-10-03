//
//  File.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: CLLocationCoordinate2D
    
    init(place: CLLocationCoordinate2D) {
        self.place = place
        super.init()
        
        position = place
        let pinImage = UIImage(named: "mapPin")!.withRenderingMode(.alwaysTemplate)
        let pinImageView = UIImageView(image: pinImage)
        pinImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 36)
        iconView = pinImageView
        
//        icon = UIImage(named: "mapPin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        
    }
}
