//
//  Section.swift
//  User
//
//  Created by User on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation

struct Section {
    var sectionName: String!
    var sectionRowData: [String]!
    var expanded: Bool!
    
    init(name: String, data: [String], expanded: Bool) {
        self.sectionName = name
        self.sectionRowData = data
        self.expanded = expanded
    }
}
