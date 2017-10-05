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
            guard let result = response.result.value as? [String : AnyObject] else{ return }

            let realm = try! Realm()
            try! realm.write {
                RealmDataManager.getRemindersFromRealm().last?.id = result["id"] as? String
            }
            completion(true)
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

                RealmDataManager.writeIntoRealm(object: reminderObject)
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
        
        
        
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
        }
    }
    
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

