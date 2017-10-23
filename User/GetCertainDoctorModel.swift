//
//  GetCertainDoctorModel.swift
//  User
//
//  Created by User on 10/17/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm
import ObjectMapperAdditions


class MappedCertainDoctorModel: Object, Mappable {
    @objc dynamic var id: String?
    @objc dynamic var email: String?
    @objc dynamic var doctorPhone: String?
    @objc dynamic var avatar: String?
    @objc dynamic var userStatus: String?
    @objc dynamic var aboutMe: String?
    let receptionPhoneNumbers = List<RealmStringTest>()
    let doctorsPhotos = List<RealmStringTest>()
    let doctorsSpecializationsList = List<DoctorsSpecializations>()
    @objc dynamic var phone: String?
    @objc dynamic var name: String?
    @objc dynamic var consultationFees: String?
    @objc dynamic var experienceYears: String?
    @objc dynamic var hospitalID: String?
    @objc dynamic var hospitalName: String?
    @objc dynamic var hospitalPhysicalAddress: String?
    @objc dynamic var hospitalAvatar: String?
    @objc dynamic var hospitalLatitude: String?
    @objc dynamic var hospitalLongitude: String?
    @objc dynamic var hospitalEditable: String?
    var doctorsSpecializations: [DoctorsSpecializations]?
    
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        doctorPhone <- map["doctor_phone"]
        avatar <- map["avatar"]
        userStatus <- map["user_status"]
        aboutMe <- map["about_me"]
        phone <- map["phone"]
        name <- map["name"]
        consultationFees <- map["consultation_fees"]
        experienceYears <- map["experience_years"]
        hospitalID <- map["hospital_id"]
        hospitalName <- map["hospital_name"]
        hospitalPhysicalAddress <- map["hospital_physical_address"]
        hospitalAvatar <- map["hospital_avatar"]
        hospitalLatitude <- map["hospital_latitude"]
        hospitalLongitude <- map["hospital_longitude"]
        hospitalEditable <- map["hospital_editable"]
        doctorsSpecializations <- map["specializations"]
        if let unwrappedTags = map.JSON["reception_phone_numbers"] as? [String] {
            for tag in unwrappedTags {
                let tagObject = RealmStringTest()
                tagObject.stringValue = tag
                receptionPhoneNumbers.append(tagObject)
            }
        }
        if let doctorsPhotos = map.JSON["doctors_photos"] as? [String] {
            for doctorPhoto in doctorsPhotos {
                let stringObject = RealmStringTest()
                stringObject.stringValue = doctorPhoto
                self.doctorsPhotos.append(stringObject)
            }
        }
        for element in doctorsSpecializations! {
            self.doctorsSpecializationsList.append(element)
        }
    }
    
    func writeIntoRealm(response: DataResponse<MappedCertainDoctorModel>){
        let result = response.result.value!
        let realm = try! Realm()
        try! realm.write {
            realm.add(result)
        }
    }
}

class RealmStringTest: Object {
    @objc dynamic var stringValue: String?
}

class DoctorsSpecializations: Object, Mappable {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var address: String?
    @objc dynamic var avatar: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        avatar <- map["avatar"]
    }
}

