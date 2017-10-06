//
//  WorkingHoursRequest.swift
//  User
//
//  Created by User on 10/6/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class WorkingHoursRequest {
    static func getWorkingHoursFor(pharmacyID: String, completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/working-hours/" + pharmacyID
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedWorkingHoursModel>) in
            MappedWorkingHoursModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
