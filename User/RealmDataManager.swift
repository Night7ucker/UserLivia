//
//  RealmDataManager.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataManager {
    
    static func writeIntoRealm(object: Object, realm: Realm) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    
}
