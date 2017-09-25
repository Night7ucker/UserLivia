//
//  TimePopupViewController.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class TimePopupViewController: UIViewController {
    
    @IBOutlet weak var timePopupViewController: UIDatePicker!
    @IBOutlet weak var timePopupViewOutlet: UIView!
    
    var delegate: TimePopupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timePopupViewOutlet.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func okTimePopupButtonTapped(_ sender: UIButton) {
        delegate.trasferDataTime(data: timePopupViewController.date)
        dismiss(animated: true, completion: nil)
    }

}
