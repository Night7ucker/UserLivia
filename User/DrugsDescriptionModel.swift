//
//  GetDrugsModel.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift


class DrugsDescriptionModel: Object{
    dynamic var id: String?
    dynamic var type = -1
    dynamic var brandName: String?
    dynamic var contraindications: String?
    dynamic var desc: String?
    dynamic var dosage: String?
    dynamic var dosageUnits: String?
    dynamic var manufacturerCompany: String?
    dynamic var name: String?
    dynamic var sideEffects: String?
   
}
