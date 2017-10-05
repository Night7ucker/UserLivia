//
//  PharmacyDetailsVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class PharmacyDetailsVC: RootViewController {

    
    @IBOutlet weak var pharmacyNameLabelOutlet: UILabel!
    
    @IBOutlet weak var pharmacyImageViewOutlet: UIImageView!
    
    @IBOutlet weak var pharmacyDetailsTableViewOutlet: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Pharmacy details")
        view.backgroundColor = Colors.Root.lightGrayColor
        
        pharmacyDetailsTableViewOutlet.delegate = self
        pharmacyDetailsTableViewOutlet.dataSource = self
        
        pharmacyDetailsTableViewOutlet.isScrollEnabled = false
        pharmacyDetailsTableViewOutlet.backgroundColor = Colors.Root.lightGrayColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PharmacyDetailsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let pharmacyAdminInfoCell = tableView.dequeueReusableCell(withIdentifier: "pharmacyAdminCell") as! PharmacyAdminCell
            pharmacyAdminInfoCell.layer.cornerRadius = 7
            
            pharmacyAdminInfoCell.pharmacyAdminNameLabelOutlet.text = "Mr. Sakharchuk"
            pharmacyAdminInfoCell.pharmacyAdminPhoneNumberLabelOutlet.text = "375296205222"
            pharmacyAdminInfoCell.pharmacyAdminPhoneNumberLabelOutlet.textColor = Colors.Root.lightBlueColor
            
            return pharmacyAdminInfoCell
        case 1:
            let workingHoursCell = tableView.dequeueReusableCell(withIdentifier: "workingHoursCell") as! WorkingHoursCell
            workingHoursCell.layer.cornerRadius = 7
            
            return workingHoursCell
        case 2:
            let pharmacyOnMapCell = tableView.dequeueReusableCell(withIdentifier: "pharmacyOnMapCell") as! PharmacyOnMapCell
            pharmacyOnMapCell.layer.cornerRadius = 7
            
            return pharmacyOnMapCell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let alertController = UIAlertController.init(title: nil, message: "Device has no phone.", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
//            toPhone:
//            guard let number = URL(string: "tel://" + number) else { return }
//            UIApplication.shared.open(number)
        case 1:
            let pharmacyDetailsStoryboard = UIStoryboard(name: "PharmacyDetails", bundle: nil)
            let workDaysViewController = pharmacyDetailsStoryboard.instantiateViewController(withIdentifier: "kWorkDaysVC") as! WorkDaysVC
            navigationController?.pushViewController(workDaysViewController, animated: false)
        case 2:
            let pharmacyDetailsStoryboard = UIStoryboard(name: "PharmacyDetails", bundle: nil)
            let pharmacyLocationViewController = pharmacyDetailsStoryboard.instantiateViewController(withIdentifier: "kPharmacyLocationVC") as! PharmacyLocationVC
            navigationController?.pushViewController(pharmacyLocationViewController, animated: false)
        default:break
        }
    }
}

extension PharmacyDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 68
        case 1:
            return 44
        case 2:
            return 220
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        return emptyView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
}








