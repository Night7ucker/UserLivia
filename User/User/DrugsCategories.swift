//
//  DrugsCategories.swift
//  User
//
//  Created by Egor Yanukovich on 10/3/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

struct DrugsCategory {
    
    var categoryName : String!
    var categoryData: [String]! // there should be drugs
    var categoryColor : UIColor!
    var expanded: Bool!
    
    init(name: String, data: [String],color : UIColor, expanded: Bool) {
        self.categoryName = name
        self.categoryData = data
        self.expanded = expanded
        self.categoryColor = color
    }
    
}
