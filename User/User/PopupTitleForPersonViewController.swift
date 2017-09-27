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
    
    var delegate: PopupTitleForPersonViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        personsTitleTableView.layer.cornerRadius = 1
        
        personsTitleTableView.delegate = self
        personsTitleTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PopupTitleForPersonViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personTitleCell", for: indexPath) as! PersonTitleTableViewCell
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
        let cell = tableView.cellForRow(at: indexPath) as? PersonTitleTableViewCell
        delegate?.trasferUsetTitle(personTitle: (cell?.personTitleLabelOutlet.text)!)
        dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
