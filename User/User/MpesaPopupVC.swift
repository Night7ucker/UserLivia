//
//  MpesaPopupVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MpesaPopupVC: RootViewController {
    @IBOutlet weak var okButtonOutlet: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        okButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }

}
