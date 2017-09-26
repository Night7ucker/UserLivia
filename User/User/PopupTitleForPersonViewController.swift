//
//  PopupTitleForPersonViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class PopupTitleForPersonViewController: UIViewController, UIImagePickerControllerDelegate {

    
    
    @IBOutlet weak var personsTitleTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        personsTitleTableView.layer.cornerRadius = 1
        
        personsTitleTableView.delegate = self
        personsTitleTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
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

extension PopupTitleForPersonViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personTitleCell", for: indexPath) as! PersonTitleTableViewCell
//        print("Dr.")
//        cell.personTitleLabelOutlet.text = "Dr."
//        
//        return cell
        switch indexPath.row {
        case 0:
            cell.personTitleLabelOutlet.text = "Dr."
            
            return cell
        case 1:
            cell.personTitleLabelOutlet.text = "Mr."
            
            return cell
        case 2:
            cell.personTitleLabelOutlet.text = "Ms."
            
            return cell
        case 3:
            cell.personTitleLabelOutlet.text = "Mrs."
            
            return cell
        case 4:
            cell.personTitleLabelOutlet.text = "Prof."
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension PopupTitleForPersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let firstPersonTitle = RealmDataManager.getPersonTitleFromRealm()

        if firstPersonTitle.count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getPersonTitleFromRealm())
            }
        }
        let cell = tableView.cellForRow(at: indexPath) as? PersonTitleTableViewCell
        let personTitle = PersonTitleModel()
        personTitle.title = (cell?.personTitleLabelOutlet.text)!
        RealmDataManager.writeIntoRealm(object: personTitle, realm: realm)
        dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
