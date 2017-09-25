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
    dynamic var medicineName: String?
    dynamic var dateTimeDaysAndYears: String?
    dynamic var dateTimeHoursAndMinutes: String?
    dynamic var checkBoxIndex = -1
}
