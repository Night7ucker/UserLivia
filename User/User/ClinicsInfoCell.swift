//
//  ClinicsInfoCell.swift
//  User
//
//  Created by User on 10/16/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ClinicsInfoCell: UITableViewCell, GMSMapViewDelegate {
    
    @IBOutlet weak var clinicPictureImageViewOutlet: UIImageView!
    
    @IBOutlet weak var clinicNameLabelOutlet: UILabel!
    
    @IBOutlet weak var clinicCountryLabelOutlet: UILabel!
    
    @IBOutlet weak var clinicsLocationMapViewOutlet: GMSMapView!
    
    
    var pharmacyLocation: CLLocationCoordinate2D!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clinicsLocationMapViewOutlet.delegate = self
        if RealmDataManager.getCertainDoctorFromRealm().count != 0 {
            pharmacyLocation = CLLocationCoordinate2D(latitude: Double((RealmDataManager.getCertainDoctorFromRealm()[0].hospitalLatitude)!)!, longitude: Double((RealmDataManager.getCertainDoctorFromRealm()[0].hospitalLongitude)!)!)
            
            let pharmacyMarker = PlaceMarker(place: pharmacyLocation)
            pharmacyMarker.map = clinicsLocationMapViewOutlet
            
            let cameraOnCurrentLocation = GMSCameraPosition.camera(withLatitude: pharmacyLocation.latitude,
                                                                   longitude: pharmacyLocation.longitude,
                                                                   zoom: 15)
            clinicsLocationMapViewOutlet.animate(to: cameraOnCurrentLocation)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
