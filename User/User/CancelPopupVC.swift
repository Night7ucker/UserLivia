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
    
    var firstCheckboxIsTapped = true
    var secondCheckboxIsTapped = false
    var thirdCheckboxIsTapped = false
    
    @IBOutlet weak var thirdCheckboxOutlet: UIButton!

    @IBOutlet weak var cancelOrderButtonOutlet: UIButton!
    
    var delegate: CancelPopupVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelOrderButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
        firstCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
    
    func getCancelReason() -> String {
        if firstCheckboxIsTapped {
            return "1"
        } else if secondCheckboxIsTapped {
            return "2"
        } else if thirdCheckboxIsTapped {
            return "3"
        }
        return String()
    }
    
    
    @IBAction func firstCheckboxTapped(_ sender: Any) {
        firstCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        secondCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        thirdCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        firstCheckboxIsTapped = true
        secondCheckboxIsTapped = false
        thirdCheckboxIsTapped = false
    }
    
    @IBAction func secondCheckboxTapped(_ sender: UIButton) {
        firstCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        secondCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        thirdCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        firstCheckboxIsTapped = false
        secondCheckboxIsTapped = true
        thirdCheckboxIsTapped = false
    }
    
    @IBAction func thirdCheckboxTapped(_ sender: UIButton) {
        firstCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        secondCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonUnchecked"), for: .normal)
        thirdCheckboxOutlet.setImage(#imageLiteral(resourceName: "radioButtonChecked"), for: .normal)
        firstCheckboxIsTapped = false
        secondCheckboxIsTapped = false
        thirdCheckboxIsTapped = true
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func cancelOrderButtonTapped(_ sender: UIButton) {
        if RealmDataManager.getOrderDescriptionModel()[0].statusId == "16" {
            CancelOrderRequest.deleteReminder(orderID: RealmDataManager.getOrderDescriptionModel()[0].orderId!, cancelReason: getCancelReason())
            dismiss(animated: false) {
                self.delegate.showLowerCostPopup(cancelReason: self.getCancelReason())
            }
        } else {
            dismiss(animated: false) {
                self.delegate.showLowerCostPopup(cancelReason: self.getCancelReason())
            }
        }
    }
}
