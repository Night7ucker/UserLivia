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
    static func getSpecialityList(parentID: String?, searchText: String = "", offset: Int = 0, completion: @escaping (Bool) -> Void) {
        var headers = [String: String]()
        let firstUrlPart = "https://test.liviaapp.com/api/specialization?parent_id=" + parentID!
        let secondUrlPart = "&offset=" + String(offset) + "&limit=20&search=" + searchText
        let finalUrl = firstUrlPart + secondUrlPart
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
                "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
                "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
                "LiviaApp-language": "en",
                "LiviaApp-timezone": "180",
                "LiviaApp-APIVersion": "2.0"
            ]
        } else {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-city": RealmDataManager.getCitiesNamesFromRealm()[0].cityId!,
                "LiviaApp-language": "en",
                "LiviaApp-timezone": "180",
                "LiviaApp-APIVersion": "2.0"
            ]
        }
        
        
        Alamofire.request(finalUrl, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedFindDoctorSpecialityModel>) in
            MappedFindDoctorSpecialityModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
