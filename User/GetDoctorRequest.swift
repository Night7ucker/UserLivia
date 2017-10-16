//
//  GetDoctorRequest.swift
//  User
//
//  Created by User on 10/12/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class GetDoctorRequest {
    static func getDoctorList(specializationID: String, searchText: String = "", offset: Int = 0, completion: @escaping (Bool) -> Void) {
        var headers = [String: String]()
        
        let firstPartOfUrl = "https://test.liviaapp.com/api/doctor?specialization_id="
        let secondPartOfUrl = specializationID + "&offset=" + String(offset) + "&limit=20&search=" + searchText
        let finalUrl = firstPartOfUrl + secondPartOfUrl
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
                "LiviaApp-laanguage": "en",
                "LiviaApp-timezone": "180",
                "LiviaApp-APIVersion": "2.0"
            ]
        }
        
        
        
        Alamofire.request(finalUrl, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedDoctorModel>) in
            if let error = response.result.error as? AFError {
                print(error)
            }
            MappedDoctorModel.writeIntoRealm(response: response)
            completion(true)
        }
    }
}
