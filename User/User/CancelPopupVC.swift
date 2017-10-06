//
//  CancelPopupVC.swift
//  User
//
//  Created by User on 10/6/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

// do you want a lower cost alternative generic

import UIKit

class CancelPopupVC: RootViewController {
    
    
    @IBOutlet weak var firstCheckboxOutlet: UIButton!
    
    
    @IBOutlet weak var secondCheckboxOutlet: UIButton!
    
    var firstCheckboxIsTapped = false
    var secondCheckboxIsTapped = false
    var thirdCheckboxIsTapped = false
    
    @IBOutlet weak var thirdCheckboxOutlet: UIButton!

    @IBOutlet weak var cancelOrderButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelOrderButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func firstCheckboxTapped(_ sender: Any) {
        firstCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        secondCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        thirdCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        firstCheckboxIsTapped = true
        secondCheckboxIsTapped = false
        thirdCheckboxIsTapped = false
    }
    
    @IBAction func secondCheckboxTapped(_ sender: UIButton) {
        firstCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        secondCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        thirdCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        firstCheckboxIsTapped = false
        secondCheckboxIsTapped = true
        thirdCheckboxIsTapped = false
    }
    
    @IBAction func thirdCheckboxTapped(_ sender: UIButton) {
        firstCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        secondCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        thirdCheckboxOutlet.setBackgroundImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        firstCheckboxIsTapped = false
        secondCheckboxIsTapped = false
        thirdCheckboxIsTapped = true
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func cancelOrderButtonTapped(_ sender: UIButton) {
    }
}
