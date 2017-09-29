//
//  ReminderRequests.swift
//  User
//
//  Created by User on 9/28/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class ReminderRequests {
    
    static func addReminder(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/reminder"
        
        let parameters: Parameters = [
            "drug_name": RealmDataManager.getRemindersFromRealm().last!.medicineName!,
            "start_date": RealmDataManager.getRemindersFromRealm().last!.dateForRequest!,
            "reminder": String(describing: RealmDataManager.getRemindersFromRealm().last!.checkBoxIndex)
        ]
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            
            let realm = try! Realm()
            try! realm.write {
                RealmDataManager.getRemindersFromRealm().last?.id = String(describing: result["id"] as? Int)
            }
        }
    }
    
    func getAllReminders(completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/reminder"
        
        let parameters: Parameters = [
            "limit": "0",
            "offset": "0"
        ]
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            guard let result = response.result.value as? [String : AnyObject] else{ return }
            guard let body = result["body"] as? [[String : AnyObject]] else { return }
            
            for element in body {
                let reminderObject = ReminderModel()
                
                reminderObject.id = element["id"] as? String
                reminderObject.medicineName = element["drug_name"] as? String
                
                let reminderCheckboxIndex = element["reminder"] as? String
                reminderObject.checkBoxIndex = Int(reminderCheckboxIndex!)!
                
                reminderObject.dateForRequest = element["start_date"] as? String
                
                let date = self.formDateFromDateFromRequest(date: reminderObject.dateForRequest!)
                reminderObject.dateTimeDaysAndYears = date.1
                reminderObject.dateTimeHoursAndMinutes = date.0
                
                let realm = try! Realm()
                RealmDataManager.writeIntoRealm(object: reminderObject, realm: realm)
            }
            
            completion(true)
        }
    }
    
    static func editReminder(reminderID: String, reminderStartDate: String, reminderDrugName: String, reminderChekboxIndex: String) {
        
        let url = "https://test.liviaapp.com/api/reminder/" + reminderID
        
        let parameters: Parameters = [
            "start_date": reminderStartDate,
            "drug_name": reminderDrugName,
            "reminder": reminderChekboxIndex
        ]
        
        let headers = [
            "Content-Type": "application/json",
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        }
    }
    
    static func deleteReminder(reminderID: String) {
        
        let url = "https://test.liviaapp.com/api/reminder/" + reminderID
        
        let headers = [
            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
            "LiviaApp-language": "en",
            "LiviaApp-timezone": "180",
            "LiviaApp-APIVersion": "2.0"
        ]
        
        
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).response { (response) in
        }
    }
    
    //    func getReminderForEditing(reminderId: String, completion: @escaping (Bool, ReminderModel) -> Void) {
    //
    //        let url = "https://test.liviaapp.com/api/reminder/" + reminderId
    //
    //        let headers = [
    //            "Content-Type": "application/json",
    //            "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
    //            "LiviApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
    //            "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
    //            "LiviaApp-language": "en",
    //            "LiviaApp-timezone": "180",
    //            "LiviaApp-APIVersion": "2.0"
    //        ]
    //
    //
    //
    //        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
    //
    //            guard let result = response.result.value as? [String : AnyObject] else{ return }
    //            guard let body = result["body"] as? [[String : AnyObject]] else { return }
    //
    //            let reminderObject = ReminderModel()
    //
    //            for element in body {
    //
    //
    //                reminderObject.id = element["id"] as? String
    //                reminderObject.medicineName = element["drug_name"] as? String
    //
    //                let reminderCheckboxIndex = element["reminder"] as? String
    //                reminderObject.checkBoxIndex = Int(reminderCheckboxIndex!)!
    //
    //                reminderObject.dateForRequest = element["start_date"] as? String
    //
    //                let date = self.formDateFromDateFromRequest(date: reminderObject.dateForRequest!)
    //                reminderObject.dateTimeDaysAndYears = date.1
    //                reminderObject.dateTimeHoursAndMinutes = date.0
    //            }
    //
    //            completion(true, reminderObject)
    //        }
    //    }
    
    func formDateFromDateFromRequest(date: String) -> (String, String) {
        var hourAndMinuteDate = String()
        var dayAndMonthDate = String()
        
        let token = date.components(separatedBy: "T")
        
        dayAndMonthDate = token[0]
        
        let hourAndTime = token[1].components(separatedBy: "+")
        hourAndMinuteDate = hourAndTime[0]
        
        return (hourAndMinuteDate, dayAndMonthDate)
    }
}

//        Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//
//            guard let result = response.result.value as? [String : AnyObject] else{ return }
//            guard let body = result["body"] as? [[String : AnyObject]] else { return }
//
//            for element in body {
//                let country = element["country"] as? String
//                let city = element["name"] as? String
//
//                let cityObject = City()
//
//                cityObject.cityName = city
//                cityObject.countryName = country
//
//                let realm = try! Realm()
//                RealmDataManager.writeIntoRealm(object: cityObject, realm: realm)
//
//            }
//            completion(true)
//        }

//    static func getCitiesForSearchRequest(searchStringForCities: String, completion: @escaping (Bool) -> Void) {
//        let headers = [
//            "LiviaApp-language": "en",
//            "LiviaApp-timezone": "180",
//            "LiviaApp-APIVersion": "2.0"
//        ]
//
//        let url = "https://test.liviaapp.com/api/city?active=1&offset=0&limit=20&search=\(searchStringForCities)"
//
//        let realm = try! Realm()
//        if RealmDataManager.getCitiesNamesFromRealm().count != 0 {
//            try! realm.write {
//                realm.delete(RealmDataManager.getCitiesNamesFromRealm())
//            }
//        }
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
//
//
//
//            guard let result = response.result.value as? [String : AnyObject] else{ return }
//            print(result)
//            guard let body = result["body"] as? [[String : AnyObject]] else { return }
//
//            for element in body {
//                let country = element["country"] as? String
//                let city = element["name"] as? String
//
//                let cityObject = City()
//
//                cityObject.cityName = city
//                cityObject.countryName = country
//
//                let realm = try! Realm()
//                RealmDataManager.writeIntoRealm(object: cityObject, realm: realm)
//
//            }
//            completion(true)
//        }
//    }

