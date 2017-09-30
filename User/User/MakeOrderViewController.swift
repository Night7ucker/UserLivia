//
//  MakeOrderViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class MakeOrderViewController: RootViewController {
    
    
    @IBOutlet weak var makeOrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        addBackButtonAndTitleToNavigationBar(title: "Request price")
        
        makeOrderTableView.layer.cornerRadius = 10
        makeOrderTableView.dataSource = self
        makeOrderTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MakeOrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            
            cell.makeOrderTopMenuLabelOutlet.text = "Take a Photo of Prescription"
            cell.makeOrderBottomMenuLabelOutlet.text = "GENERATE ORDER FROM YOUR PHOTO"
            cell.makeOrderIconImageOutlet.image = UIImage(named: "makeOrderPhoto")
            cell.imageInsideImageMakeOrderOutlet.image = UIImage(named: "cameraFromMakeOrder")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "makeOrderCell", for: indexPath) as! MakeOrderCellTableViewCell
            cell.makeOrderTopMenuLabelOutlet.text = "Search for medicines / items"
            cell.makeOrderBottomMenuLabelOutlet.text = "SEARCH FROM 1003 DRUGS"
            cell.makeOrderIconImageOutlet.image = UIImage(named: "makeOrderPhoto")
            cell.imageInsideImageMakeOrderOutlet.image = UIImage(named: "searchFromMakeOrder")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1){
            let GetDrugsStoryboard = UIStoryboard(name: "SearchDrugs", bundle: nil)
            let GetDrugsViewController = GetDrugsStoryboard.instantiateViewController(withIdentifier: "kSearchDrugsStoryboardId") as? GetDrugsViewController
            navigationController?.pushViewController(GetDrugsViewController!, animated: true)

        }
    }
}

extension MakeOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
