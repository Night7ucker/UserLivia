//
//  CountryDataManager.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper
import ObjectMapper_Realm

class GetCountryCodesRequest{


    
    func getCountryCodes() {
        let url = "https://test.liviaapp.com/api/settings"
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-language": "en"
        ]
        Alamofire.request(url, method: .get, headers: headers).responseObject { (response: DataResponse<MappedCountryCodesModel>) in
            MappedCountryCodesModel.writeIntoRealm(response: response)
        }
    }
  

    
}






