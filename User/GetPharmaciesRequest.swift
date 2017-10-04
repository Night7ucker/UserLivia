//
//  GetPharmaciesRequest.swift
//  User
//
//  Created by User on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm
import GoogleMaps

class GetPharmaciesRequest {
    static func getPharmacies(coordinate: CLLocationCoordinate2D) {
        let url = "https://test.liviaapp.com/api/order?latitude=\(coordinate.latitude)&longtitude=\(coordinate.longitude)"
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedPharmacyModel>) in
            MappedPharmacyModel.writeIntoRealm(response: response)
        }
    }
}
