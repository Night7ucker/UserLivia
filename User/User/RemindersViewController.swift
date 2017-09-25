//
//  RemindersModule.swift
//  User
//
//  Created by User on 9/25/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

// make realm model with reminder
// make deleting on reminder table

import UIKit

class RemindersViewController: UIViewController {
    
    @IBOutlet weak var remindersTableViewOutlet: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remindersTableViewOutlet.isHidden = true
        let addReminderButton = UIButton(type: .system)
        addReminderButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        addReminderButton.setTitle("+", for: .normal)
        addReminderButton.titleLabel?.font = UIFont(name: "Arial", size: 45)
        addReminderButton.titleLabel?.font = UIFont.systemFont(ofSize: 34, weight: UIFontWeightThin)
        
        addReminderButton.setTitleColor(.white, for: .normal)
        addReminderButton.titleEdgeInsets = UIEdgeInsetsMake(5, 25, 0, 0)
        addReminderButton.addTarget(self, action: #selector(addTapped(_ :)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addReminderButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addTapped(_ sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey: nil)
        
        let refillsAndRemindersStoryboard = UIStoryboard(name: "RefillsAndReminders", bundle: nil)
        let addReminderViewController = refillsAndRemindersStoryboard.instantiateViewController(withIdentifier: "kAddReminderViewController") as? AddReminderViewController
        navigationController?.pushViewController(addReminderViewController!, animated: false)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
