//
//  CustomImageView.swift
//  User
//
//  Created by Egor Yanukovich on 9/24/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup()
    {
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }
    
}
