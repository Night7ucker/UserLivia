//
//  SpecializationsHeaderView.swift
//  User
//
//  Created by User on 10/18/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

//
//  MyView.swift
//  User
//
//  Created by BAMFAdmin on 10.10.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SpecializationsHeaderView: UIView {
    @IBOutlet weak var specializationsLabelOutlet: UILabel!
    
    @IBOutlet weak var arrowLabelOutlet: UILabel!
    var delegate: SpecializationsHeaderViewDelegate!
    
    
    override func awakeFromNib() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(specializationHeaderTapped(_ :)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func specializationHeaderTapped(_ sender: UITapGestureRecognizer) {
        delegate.specializatinHeaderViewExpand()
    }
}

