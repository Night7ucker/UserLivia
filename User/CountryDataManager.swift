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


class CountryCodesDataManager{

    let url = "https://test.liviaapp.com/api/settings"
    let headers = [
        "Content-Type": "application/json",
        "LiviaApp-language": "en"
    ]
 
    func getCountryCodes() {
        

        Alamofire.request(url, method: .get, headers: headers).responseJSON { (response) in
            
            guard let result = response.result.value as? [String: AnyObject] else{ return }
            guard let listOfCountries = result["list_of_countries"] as? [[String: AnyObject]] else{ return }

            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            for element in listOfCountries {
                let realmObject = CountryCodesModel()
                realmObject.countryFlag = element["flag"] as? String
                realmObject.countryName = element["name"] as? String
                realmObject.phoneCode = element["phone_country_code"] as? String
                
               RealmDataManager.writeIntoRealm(object: realmObject, realm: realm)
            }
        }

    }
    
    func getImage(pictureUrl: String?, onCompletion: @escaping (Bool, UIImage?) -> Void) {
        if let urlRequest = pictureUrl {
            Alamofire.request(urlRequest).responseData(completionHandler: { (response) in
                if response.error == nil, let imageData = response.data {
                    let image = UIImage(data: imageData)!
                    onCompletion(true, image)
                } else {
                    onCompletion(false, nil)
                }
            })
        }
    }
    
}






