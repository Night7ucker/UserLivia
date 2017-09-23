//
//  FillRegistrationInfoViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//
// todo:
// popup for person title (doctor or other)
// get images from somewhere
// add fucntionality on check button
// add functionality on link terms and conditions
// make next button blue color when all fields are set

import UIKit
import RealmSwift

class FillRegistrationInfoViewController: UIViewController {
    
    var token = NotificationToken()
    let realm = try! Realm()

    @IBOutlet weak var personTitleLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var ageTextFieldOutlet: UITextField!
    @IBOutlet weak var femaleLabelOutlet: UILabel!
    @IBOutlet weak var maleLabelOutlet: UILabel!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var check18YearsOldImageViewOutlet: UIImageView!
    @IBOutlet weak var checkTermsAndConditionsImageViewOutlet: UIImageView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var openTermsLinkButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! realm.write {
            realm.deleteAll()
        }
        
        femaleLabelOutlet.backgroundColor = .blue
        femaleLabelOutlet.textColor = .white
        maleLabelOutlet.backgroundColor = .gray
        maleLabelOutlet.textColor = .blue
        nextButtonOutlet.layer.cornerRadius = 2
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
       
        token = realm.addNotificationBlock { (notifcation, realm) -> Void in
            
            if RealmDataManager.getPersonTitleFromRealm().count > 0 {
            self.personTitleLabelOutlet.text = RealmDataManager.getPersonTitleFromRealm()[0].title
            }
           
               //
            
 
            
        }
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        token.stop()
    }

    @IBAction func femaleButtonTouched(_ sender: UIButton) {
        femaleLabelOutlet.backgroundColor = .gray
        femaleLabelOutlet.textColor = .blue
        maleLabelOutlet.backgroundColor = .blue
        maleLabelOutlet.textColor = .white
    }
    
    @IBAction func maleButtonTouched(_ sender: UIButton) {
        maleLabelOutlet.backgroundColor = .gray
        maleLabelOutlet.textColor = .blue
        femaleLabelOutlet.backgroundColor = .blue
        femaleLabelOutlet.textColor = .white
    }
    @IBAction func check18YearsOldButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func agreeWithTermsButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func changeTitleButtonTapped(_ sender: UIButton) {
        
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
