//
//  WorkingHoursModel.swift
//  User
//
//  Created by User on 10/6/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm

class MappedWorkingHoursModel: Mappable {
    var workingHoursModel: [WorkingHour]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        workingHoursModel <- map["body"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedWorkingHoursModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.workingHoursModel {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class WorkingHour: Object, Mappable {
    dynamic var dayInWeek: String?
    dynamic var dayType: String?
    dynamic var startWork: String?
    dynamic var endWork: String?
    dynamic var startLunch: String?
    dynamic var endLunch: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dayInWeek <- map["day_in_week"]
        dayType <- map["day_type"]
        startWork <- map["start_work"]
        endWork <- map["end_work"]
        startLunch <- map["start_lunch"]
        endLunch <- map["end_lunch"]
    }
    
}
