//
//  OrderSendedPopupViewController.swift
//  User
//
//  Created by User on 10/4/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class OrderSendedPopupViewController: RootViewController {

    @IBOutlet weak var thankUForUsingLiviaLabelOutlet: UILabel!
    
    
    @IBOutlet weak var thankTextViewOutlet: UITextView!
    
    
    @IBOutlet weak var closeButtonOutlet: UIButton!
    
    @IBOutlet weak var popupViewOutlet: UIView!
    
    var delegate: OrderSendedPopupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupViewOutlet.layer.cornerRadius = 1
        closeButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
        thankTextViewOutlet.textColor = Colors.Root.greenColorForNavigationBar
        thankUForUsingLiviaLabelOutlet.textColor = Colors.Root.greenColorForNavigationBar
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false) {
            self.delegate.pushtToMainScreenController()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate.pushtToMainScreenController()
        }
    }

}
