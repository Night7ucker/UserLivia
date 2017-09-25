//
//  CalendarPopupViewController.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class CalendarPopupViewController: UIViewController {

    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var popupViewOutlet: UIView!
    
    var delegate: CalendarPopupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupViewOutlet.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func okButtonTapped(_ sender: UIButton) {
        delegate.transferData(data: datePickerOutlet.date)
        dismiss(animated: true, completion: nil)
    }

}
