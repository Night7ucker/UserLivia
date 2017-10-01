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
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en",
            "LiviaApp-country": "ke",
            "LiviaApp-city": "200787",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <MappedGetDrugsModel>) in
            MappedGetDrugsModel.writeIntoRealm(response: response)
            completion(true)
        }
        
    }
}

