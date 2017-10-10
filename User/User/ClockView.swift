//
//  clockView.swift
//  User
//
//  Created by BAMFAdmin on 09.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class ClockView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        rotate()
    }
    
        func rotate()
        {
            var rotationAnimation = CABasicAnimation()
            rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = NSNumber(value: (Double.pi))
            rotationAnimation.duration = 0.7
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount = .infinity
            layer.add(rotationAnimation, forKey: "rotationAnimation")
        }
}
