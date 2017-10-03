//
//  DrugPageButton.swift
//  User
//
//  Created by BAMFAdmin on 28.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class DrugsView: UIView {

    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
    
            layer.insertSublayer(shadowLayer, at: 0)

        }        
    }

}
