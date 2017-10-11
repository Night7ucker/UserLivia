//
//  ReminderModel.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class ReminderModel: Object {
    @objc dynamic var medicineName: String?
    @objc dynamic var dateTimeDaysAndYears: String?
    @objc dynamic var dateTimeHoursAndMinutes: String?
    @objc dynamic var checkBoxIndex = -1
    @objc dynamic var dateForRequest: String?
    @objc dynamic var id: String?
}
