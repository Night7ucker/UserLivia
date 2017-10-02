//
//  InviteFriendsController.swift
//  User
//
//  Created by Egor Yanukovich on 10/2/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import Contacts


var heightForRow : CGFloat = 80
var heightForHeader : CGFloat = 44

class InviteFriendsController: UIViewController {
    
    var contactStore = CNContactStore()
    var contacts = [Contact]()
    
    
    @IBOutlet weak var shareLinkView: UIView!
    @IBOutlet weak var inviteFriendsTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        shareLinkView.layer.cornerRadius = 5.0
        shareLinkView.layer.masksToBounds = true
        
        inviteFriendsTableView.delegate = self
        inviteFriendsTableView.dataSource = self
        
          inviteFriendsTableView.register(UINib(nibName: "ContactsCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteFriendsTableView.isHidden = true
        noDataLabel.isHidden = false
        noDataLabel.text = "Retrieving contacts..."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAccessToContacts { (success) in
            if success {
                self.retrieveContacts({ (success, contacts) in
                    self.inviteFriendsTableView.isHidden = !success
                    self.noDataLabel.isHidden = success
                    if success && (contacts?.count)! > 0 {
                        self.contacts = contacts!
                        self.inviteFriendsTableView.reloadData()
                    } else {
                        self.noDataLabel.text = "Unable to get contacts..."
                    }
                })
            }
        }
    }
    
    
    func requestAccessToContacts(_ completion: @escaping (_ success: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized: completion(true) // authorized previously
        case .denied, .notDetermined: // needs to ask for authorization
            self.contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (accessGranted, error) -> Void in
                completion(accessGranted)
            })
        default: // not authorized.
            completion(false)
        }
    }
    
    func retrieveContacts(_ completion: (_ success: Bool, _ contacts: [Contact]?) -> Void) {
        var contacts = [Contact]()
        do {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactImageDataKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
            try contactStore.enumerateContacts(with: contactsFetchRequest, usingBlock: { (cnContact, error) in
                if let contact = Contact(cnContact: cnContact) { contacts.append(contact) }
            })
            completion(true, contacts)
        } catch {
            completion(false, nil)
        }
    }
    //MARK: - Actions
    
    @IBAction func goBackToMainScreen(_ sender: UIButton) {
        
        print("Please, add reference to this controller before tapping on the button")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareLink(_ sender: UIButton) {
        //не знаю, что тут надо делать
        print("Share link")
    }
    
    
}

extension InviteFriendsController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactsCell  = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! ContactsCell
        let contact = contacts[indexPath.row]
        cell.configureWithContactEntry(contact)
        
        return cell
    }
}

extension InviteFriendsController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return heightForHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as! HeaderView
        
        return headerView
    }
    
}
