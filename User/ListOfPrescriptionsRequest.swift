//
//  ListOfPrescriptionsRequest.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class PrescriptionListRequest {
    static func getPrescriptionList(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/prescription"
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        let parameters: Parameters = [
            "limit": "20",
            "offset": "0"
        ]
        
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedPrescriptionListModel>) in
            MappedPrescriptionListModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
