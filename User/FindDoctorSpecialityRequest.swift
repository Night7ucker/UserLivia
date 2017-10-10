//
//  FindDoctorSpecialityRequest.swift
//  User
//
//  Created by User on 10/9/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class FindDoctorSpecialityRequest {
    static func getSpecialityList(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/specialization?parent_id=0&offset=0&limit=20&search="
        
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
            <MappedFindDoctorSpecialityModel>) in
            MappedFindDoctorSpecialityModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
