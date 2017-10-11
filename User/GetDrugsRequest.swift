//
//  GetDrugsRequest.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class GetDrugsRequest {
    func findDrugs(drugName: String, completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/search?search_type=drug"
        let parameters: Parameters = [
            "name": drugName
        ]
        var headers = [String: String]()
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
                "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
                "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
                "LiviaApp-APIVersion": "2.0"
            ]
        } else {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-country": "by",
                "LiviaApp-city": "625144",
                "LiviaApp-APIVersion": "2.0"
            ]
        }
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedGetDrugsModel>) in
            MappedGetDrugsModel.writeIntoRealm(response: response)
            completion(true)
        }
        
    }
}

